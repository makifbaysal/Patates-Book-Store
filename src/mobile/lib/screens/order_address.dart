import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/base_widget.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/p_text_field.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/molecules/dialog.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/enums/dialog_action_state.dart';
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class OrderAddress extends StatefulWidget {
  final String addressID;
  final Function showSnackBar;

  OrderAddress({Key key, this.addressID, this.showSnackBar}) : super(key: key);

  @override
  _OrderAddressState createState() => _OrderAddressState();
}

class _OrderAddressState extends State<OrderAddress> {
  TextEditingController _addressHeaderController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _countyController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();

  bool _autoValidate = false;

  FocusNode addressHeaderFocusNode = new FocusNode();
  FocusNode addressFocusNode = new FocusNode();
  FocusNode countyFocusNode = new FocusNode();
  FocusNode cityFocusNode = new FocusNode();
  FocusNode zipCodeFocusNode = new FocusNode();

  AddressDetailsOutputDTO addressDetail;

  GlobalKey<FormState> formKey = new GlobalKey();

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    _addressHeaderController.dispose();
    _addressController.dispose();
    _countyController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();

    addressHeaderFocusNode.dispose();
    addressFocusNode.dispose();
    countyFocusNode.dispose();
    cityFocusNode.dispose();
    zipCodeFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PColors.darkBackground,
        appBar: PAppBar(
          isCenter: true,
          children: <Widget>[
            Text(
              FlutterI18n.translate(context, widget.addressID == null ? "OrderAddress.addAddress" : "OrderAddress.editAddress"),
              style: FontStyles.header(),
            )
          ],
        ),
        body: Consumer<UserProvider>(
          builder: (BuildContext context, UserProvider model, Widget child) => BaseWidget<UserProvider>(
            model: model,
            onModelReady: () async {
              if (widget.addressID != null) {
                var response = await model.getAddressDetail(widget.addressID);
                _addressHeaderController.text = response.header;
                _addressController.text = response.address;
                _countyController.text = response.county;
                _cityController.text = response.city;
                _zipCodeController.text = response.zipcode;
                setState(() {});
              }
            },
            builder: (BuildContext context, UserProvider model, Widget child) => model.state != ServerState.Busy
                ? Form(
                    key: formKey,
                    autovalidate: _autoValidate,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                              Expanded(
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  children: <Widget>[
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                FlutterI18n.translate(context, "OrderAddress.addressHeader"),
                                                style: FontStyles.header(textColor: PColors.white),
                                              ),
                                              SizedBox(height: 12),
                                              Container(
                                                height: 61,
                                                child: PTextField(
                                                  controller: _addressHeaderController,
                                                  focusNode: addressHeaderFocusNode,
                                                  requestFocus: _requestFocus,
                                                  placeholderText: FlutterI18n.translate(context, "OrderAddress.addressHeaderPlaceholder"),
                                                  onPressed: () {},
                                                  validator: (String value) {
                                                    if (value.isEmpty)
                                                      return FlutterI18n.translate(context, "OrderAddress.addressHeaderWarning");
                                                    else
                                                      return null;
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 16),
                                              Text(
                                                FlutterI18n.translate(context, "OrderAddress.address"),
                                                style: FontStyles.header(textColor: PColors.white),
                                              ),
                                              SizedBox(height: 12),
                                              Container(
                                                height: 100,
                                                child: PTextField(
                                                  controller: _addressController,
                                                  focusNode: addressFocusNode,
                                                  requestFocus: _requestFocus,
                                                  placeholderText: FlutterI18n.translate(context, "OrderAddress.addressPlaceholder"),
                                                  maxLine: 4,
                                                  onPressed: () {},
                                                  validator: (String value) {
                                                    if (value.isEmpty)
                                                      return FlutterI18n.translate(context, "OrderAddress.addressPlaceholder");
                                                    else
                                                      return null;
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 16),
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 5,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text(
                                                          FlutterI18n.translate(context, "OrderAddress.county"),
                                                          style: FontStyles.header(textColor: PColors.white),
                                                        ),
                                                        SizedBox(height: 12),
                                                        Container(
                                                          height: 61,
                                                          child: PTextField(
                                                            controller: _countyController,
                                                            focusNode: countyFocusNode,
                                                            requestFocus: _requestFocus,
                                                            placeholderText: FlutterI18n.translate(context, "OrderAddress.countyPlaceholder"),
                                                            onPressed: () {},
                                                            validator: (String value) {
                                                              if (value.isEmpty)
                                                                return FlutterI18n.translate(context, "OrderAddress.countyPlaceholder");
                                                              else
                                                                return null;
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 12),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Text(
                                                          FlutterI18n.translate(context, "OrderAddress.city"),
                                                          style: FontStyles.header(textColor: PColors.white),
                                                        ),
                                                        SizedBox(height: 12),
                                                        Container(
                                                          height: 61,
                                                          child: PTextField(
                                                            controller: _cityController,
                                                            focusNode: cityFocusNode,
                                                            requestFocus: _requestFocus,
                                                            placeholderText: FlutterI18n.translate(context, "OrderAddress.cityPlaceholder"),
                                                            onPressed: () {},
                                                            validator: (String value) {
                                                              if (value.isEmpty)
                                                                return FlutterI18n.translate(context, "OrderAddress.cityPlaceholder");
                                                              else
                                                                return null;
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 16),
                                              Text(
                                                FlutterI18n.translate(context, "OrderAddress.zipcode"),
                                                style: FontStyles.header(textColor: PColors.white),
                                              ),
                                              SizedBox(height: 12),
                                              Container(
                                                height: 61,
                                                child: PTextField(
                                                  controller: _zipCodeController,
                                                  focusNode: zipCodeFocusNode,
                                                  requestFocus: _requestFocus,
                                                  keyboardType: TextInputType.number,
                                                  placeholderText: FlutterI18n.translate(context, "OrderAddress.zipcodePlaceholder"),
                                                  onPressed: () {},
                                                  validator: (String value) {
                                                    if (value.isEmpty)
                                                      return FlutterI18n.translate(context, "OrderAddress.zipcodePlaceholder");
                                                    else
                                                      return null;
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 16),
                                            ],
                                          ),
                                        ]),
                                  ],
                                ),
                              ),
                              PButton(
                                text: FlutterI18n.translate(context, "OrderAddress.confirm"),
                                onPressed: () async {
                                  if (formKey.currentState.validate()) {
                                    var response = await model.addAddress(_addressHeaderController.text, _addressController.text,
                                        _cityController.text, _countyController.text, _zipCodeController.text);
                                    if (response == "Error") {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text(
                                        FlutterI18n.translate(context, "OrderAddress.addAddressError"),
                                      )));
                                    } else {
                                      Navigator.pop(context);
                                      widget.showSnackBar(FlutterI18n.translate(context, "OrderAddress.addAddressSuccess"));
                                    }
                                  }
                                },
                              ),
                            ] +
                            (widget.addressID != null
                                ? [
                                    SizedBox(height: 16),
                                    PButton(
                                      text: FlutterI18n.translate(context, "OrderAddress.delete"),
                                      color: PColors.red,
                                      onPressed: () async {
                                        final action = await OPDialog.yesAbortDialog(
                                          context,
                                          FlutterI18n.translate(context, "OrderAddress.ensureDeleteAddress"),
                                          FlutterI18n.translate(context, "OrderAddress.confirm"),
                                          FlutterI18n.translate(context, "OrderAddress.reject"),
                                        );
                                        if (action == DialogActionState.Yes) {
                                          var response = await model.deleteAddress(widget.addressID);
                                          if (response == "Error") {
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                                content: Text(
                                              FlutterI18n.translate(context, "OrderAddress.deleteAddressError"),
                                            )));
                                          } else {
                                            Navigator.pop(context);
                                            widget.showSnackBar(FlutterI18n.translate(context, "OrderAddress.deleteAddressSuccess"));
                                          }
                                        }
                                      },
                                    )
                                  ]
                                : []),
                      ),
                    ),
                  )
                : Loading(),
          ),
        ));
  }
}
