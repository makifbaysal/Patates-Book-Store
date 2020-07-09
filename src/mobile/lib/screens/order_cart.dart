import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/base_widget.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/p_text_field.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class OrderCart extends StatefulWidget {
  final String cartID;
  final Function showSnackBar;

  OrderCart({Key key, this.cartID, this.showSnackBar}) : super(key: key);

  @override
  _OrderCartState createState() => _OrderCartState();
}

class _OrderCartState extends State<OrderCart> {
  TextEditingController _cartNumberController = TextEditingController();
  TextEditingController _ownerController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _cvcController = TextEditingController();

  bool _autoValidate = false;

  FocusNode cartNumberFocusNode = new FocusNode();
  FocusNode ownerFocusNode = new FocusNode();
  FocusNode dateFocusNode = new FocusNode();
  FocusNode cvcFocusNode = new FocusNode();

  CreditCartDetailsOutputDTO cartDetail;

  GlobalKey<FormState> formKey = new GlobalKey();

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    _cartNumberController.dispose();
    _ownerController.dispose();
    _dateController.dispose();
    _cvcController.dispose();

    cartNumberFocusNode.dispose();
    ownerFocusNode.dispose();
    dateFocusNode.dispose();
    cvcFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      resizeToAvoidBottomPadding: false,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(widget.cartID == null ? FlutterI18n.translate(context, "OrderCard.addCard") : FlutterI18n.translate(context, "OrderCard.updateCard")),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (BuildContext context, UserProvider model, Widget child) => BaseWidget<UserProvider>(
          model: model,
          onModelReady: () async {
            if (widget.cartID != null) {
              var response = await model.creditCardDetails(widget.cartID);
              _ownerController.text = response.owner;
              _cartNumberController.text = response.cartNumber;
              _dateController.text = response.date;
              _cvcController.text = response.cvc;
              setState(() {});
            }
          },
          builder: (BuildContext context, UserProvider model, Widget child) => model.state != ServerState.Busy
              ? Form(
                  key: formKey,
                  autovalidate: _autoValidate,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    FlutterI18n.translate(context, "OrderCard.cardOwner"),
                                    style: FontStyles.header(textColor: PColors.white),
                                  ),
                                  SizedBox(height: 12),
                                  PTextField(
                                    controller: _ownerController,
                                    focusNode: ownerFocusNode,
                                    requestFocus: _requestFocus,
                                    placeholderText: FlutterI18n.translate(context, "OrderCard.nameOnCard"),
                                    validator: (String value) {
                                      if (value.isEmpty)
                                        return FlutterI18n.translate(context, "OrderCard.nameOnCard");
                                      else
                                        return null;
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    FlutterI18n.translate(context, "OrderCard.cardNumber"),
                                    style: FontStyles.header(textColor: PColors.white),
                                  ),
                                  SizedBox(height: 12),
                                  PTextField(
                                    controller: _cartNumberController,
                                    focusNode: cartNumberFocusNode,
                                    keyboardType: TextInputType.number,
                                    requestFocus: _requestFocus,
                                    placeholderText: FlutterI18n.translate(context, "OrderCard.cardNumber"),
                                    validator: (String value) {
                                      if (value.isEmpty)
                                        return FlutterI18n.translate(context, "OrderCard.enterCardNumber");
                                      else {
                                        if (value.length < 16) {
                                          return FlutterI18n.translate(context, "OrderCard.enterFullCardNumber");
                                        }
                                        return null;
                                      }
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    FlutterI18n.translate(context, "OrderCard.date"),
                                    style: FontStyles.header(textColor: PColors.white),
                                  ),
                                  SizedBox(height: 12),
                                  PTextField(
                                    controller: _dateController,
                                    focusNode: dateFocusNode,
                                    requestFocus: _requestFocus,
                                    keyboardType: TextInputType.datetime,
                                    placeholderText: FlutterI18n.translate(context, "OrderCard.dateFormat"),
                                    validator: (String value) {
                                      if (value.isEmpty)
                                        return FlutterI18n.translate(context, "OrderCard.enterDate");
                                      else {
                                        int year;
                                        int month;
                                        DateTime now = DateTime.now();
                                        if (value.contains("/")) {
                                          var split = value.split("/");
                                          month = int.parse(split[0]);
                                          year = int.parse(split[1]);
                                          if (year < now.year - 2000)
                                            return FlutterI18n.translate(context, "OrderCard.expiredDateError");
                                          else if (month > 12 || month < 1)
                                            return FlutterI18n.translate(context, "OrderCard.wrongMonth");
                                          else if (month < now.month && year == now.year - 2000)
                                            return FlutterI18n.translate(context, "OrderCard.wrongMonthYear");
                                          else
                                            return null;
                                        } else {
                                          month = int.parse(value.substring(0, (value.length)));
                                          year = -1;
                                          return FlutterI18n.translate(context, "OrderCard.wrongFormat");
                                        }
                                      }
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    FlutterI18n.translate(context, "OrderCard.CVCCode"),
                                    style: FontStyles.header(textColor: PColors.white),
                                  ),
                                  SizedBox(height: 12),
                                  PTextField(
                                    controller: _cvcController,
                                    focusNode: cvcFocusNode,
                                    requestFocus: _requestFocus,
                                    keyboardType: TextInputType.number,
                                    placeholderText: "CVC",
                                    validator: (String value) {
                                      if (value.isEmpty)
                                        return FlutterI18n.translate(context, "OrderCard.enterCVC");
                                      else if (value.length != 3)
                                        return FlutterI18n.translate(context, "OrderCard.enterValidCVC");
                                      else
                                        return null;
                                    },
                                  ),
                                  SizedBox(height: 16),
                                ],
                              ),
                              PButton(
                                text: FlutterI18n.translate(context, "OrderCard.confirm"),
                                onPressed: () async {
                                  if (formKey.currentState.validate()) {
                                    if (widget.cartID != null) {
                                      var response = await model.updateCreditCard(_ownerController.text, _cartNumberController.text,
                                          _dateController.text, _cvcController.text, widget.cartID);
                                      if (response == "Success") {
                                        Navigator.pop(context);
                                        widget.showSnackBar(FlutterI18n.translate(context, "OrderCard.creditCardUpdateSuccess"));
                                      } else {
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text(FlutterI18n.translate(context, "OrderCard.creditCardUpdateError")),
                                        ));
                                      }
                                    } else {
                                      var response = await model.addCreditCard(
                                          _ownerController.text, _cartNumberController.text, _dateController.text, _cvcController.text);
                                      if (response == "Success") {
                                        Navigator.pop(context);
                                        widget.showSnackBar(FlutterI18n.translate(context, "OrderCard.addCreditCardSuccess"));
                                      } else {
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text(FlutterI18n.translate(context, "OrderCard.addCreditCardError")),
                                        ));
                                      }
                                    }
                                  }
                                },
                              ),
                            ] +
                            (widget.cartID != null
                                ? [
                                    SizedBox(height: 16),
                                    PButton(
                                      text: "Sil",
                                      color: PColors.red,
                                      onPressed: () async {
                                        var response = await model.deleteCreditCart(widget.cartID);
                                        if (response == "Success") {
                                          Navigator.pop(context);
                                          widget.showSnackBar(FlutterI18n.translate(context, "OrderCard.deleteCreditCardSuccess"));
                                        } else {
                                          Scaffold.of(context).showSnackBar(SnackBar(
                                            content: Text(FlutterI18n.translate(context, "OrderCard.deleteCreditCardError")),
                                          ));
                                        }
                                      },
                                    )
                                  ]
                                : []),
                      ),
                    ),
                  ),
                )
              : Loading(),
        ),
      ),
    );
  }
}
