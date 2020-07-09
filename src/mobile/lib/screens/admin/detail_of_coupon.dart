import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/base_widget.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/p_text_field.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/models/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class DetailOfCoupon extends StatefulWidget {
  final String couponID;
  final Function showSnackBar;

  const DetailOfCoupon({Key key, this.couponID, this.showSnackBar}) : super(key: key);

  @override
  _DetailOfCouponState createState() => _DetailOfCouponState();
}

class _DetailOfCouponState extends State<DetailOfCoupon> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _discountController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _countController = TextEditingController();
  TextEditingController _leftCountController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime startDate;
  DateTime endDate;

  final f = new DateFormat('dd/MM/yyyy');
  bool isEditable = false;
  CouponCodeDetailsDTO coupon;

  FocusNode nameFocus = new FocusNode();
  FocusNode codeFocus = new FocusNode();
  FocusNode discountFocus = new FocusNode();
  FocusNode startDateFocus = new FocusNode();
  FocusNode endDateFocus = new FocusNode();
  FocusNode countFocus = new FocusNode();
  FocusNode leftCountFocus = new FocusNode();
  FocusNode descriptionFocus = new FocusNode();

  GlobalKey<FormState> formKey = new GlobalKey();

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _discountController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _countController.dispose();
    _leftCountController.dispose();
    _descriptionController.dispose();

    nameFocus.dispose();
    codeFocus.dispose();
    discountFocus.dispose();
    startDateFocus.dispose();
    endDateFocus.dispose();
    countFocus.dispose();
    leftCountFocus.dispose();

    descriptionFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        leading: isEditable
            ? IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    isEditable = false;
                    startDate = coupon.startTime;
                    endDate = coupon.expireTime;
                    _nameController.text = coupon.header;
                    _codeController.text = coupon.code;
                    _descriptionController.text = coupon.description;
                    _discountController.text = coupon.percentageDiscount.toString();
                    _countController.text = coupon.startQuantity.toString();
                    _leftCountController.text = coupon.remainingQuantity.toString();
                    _startDateController.text = f.format(startDate);
                    _endDateController.text = f.format(endDate);
                  });
                },
              )
            : null,
        children: <Widget>[Text(FlutterI18n.translate(context, "DetailOfCoupon.header"), style: FontStyles.header())],
        actions: <Widget>[
          !isEditable
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isEditable = true;
                    });
                  },
                  child: Icon(PIcons.edit, color: PColors.white, size: 25),
                )
              : Consumer<AdminProvider>(
                  builder: (BuildContext context, AdminProvider model, Widget child) => GestureDetector(
                    onTap: () async {
                      var response = await model.updateCouponCode(
                          widget.couponID,
                          _nameController.text,
                          _codeController.text,
                          _descriptionController.text,
                          int.parse(_leftCountController.text),
                          int.parse(_countController.text),
                          50,
                          double.parse(_discountController.text),
                          endDate,
                          startDate);
                      if (response == "Error") {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                          FlutterI18n.translate(context, "DetailOfCoupon.errorUpdate"),
                        )));
                      } else {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                          FlutterI18n.translate(context, "DetailOfCoupon.successUpdate"),
                        )));
                        setState(() {
                          isEditable = false;
                        });
                      }
                    },
                    child: Icon(PIcons.save, color: PColors.white, size: 25),
                  ),
                ),
          SizedBox(width: 16),
          !isEditable
              ? Consumer<AdminProvider>(
                  builder: (BuildContext context, AdminProvider model, Widget child) => GestureDetector(
                    onTap: () async {
                      var response = await model.deleteCoupon(widget.couponID);
                      if (response == "Error") {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                          FlutterI18n.translate(context, "DetailOfCoupon.successDelete"),
                        )));
                      } else {
                        Navigator.pop(context);
                        widget.showSnackBar("DetailOfCoupon.successDelete");
                      }
                    },
                    child: Icon(PIcons.delete, color: PColors.red, size: 25),
                  ),
                )
              : Container()
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: Consumer<AdminProvider>(
                builder: (BuildContext context, AdminProvider model, Widget child) => BaseWidget<AdminProvider>(
                  model: model,
                  onModelReady: () async {
                    var response = await model.getCouponCodeDetails(widget.couponID);
                    coupon = response;
                    startDate = response.startTime;
                    endDate = response.expireTime;
                    _nameController.text = response.header;
                    _codeController.text = response.code;
                    _descriptionController.text = response.description;
                    _discountController.text = response.percentageDiscount.toString();
                    _countController.text = response.startQuantity.toString();
                    _leftCountController.text = response.remainingQuantity.toString();
                    _startDateController.text = f.format(startDate);
                    _endDateController.text = f.format(endDate);
                  },
                  builder: (context, model, child) => model.state != ServerState.Busy
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Text(
                              FlutterI18n.translate(context, "AddCoupon.nameHeader"),
                              style: FontStyles.bigTextField(textColor: PColors.blueGrey),
                            ),
                            SizedBox(height: 8),
                            PTextField(
                              controller: _nameController,
                              focusNode: nameFocus,
                              requestFocus: _requestFocus,
                              enabled: isEditable,
                              placeholderText: FlutterI18n.translate(context, "AddCoupon.nameHeader"),
                            ),
                            SizedBox(height: 28),
                            Text(FlutterI18n.translate(context, "AddCoupon.codeHeader"), style: FontStyles.bigTextField(textColor: PColors.blueGrey)),
                            SizedBox(height: 8),
                            PTextField(
                              controller: _codeController,
                              focusNode: codeFocus,
                              requestFocus: _requestFocus,
                              enabled: isEditable,
                              placeholderText: FlutterI18n.translate(context, "AddCoupon.codeHeader"),
                            ),
                            SizedBox(height: 28),
                            Text(FlutterI18n.translate(context, "AddCoupon.exp"), style: FontStyles.header(textColor: PColors.blueGrey)),
                            SizedBox(
                              height: 8,
                            ),
                            PTextField(
                              controller: _descriptionController,
                              focusNode: descriptionFocus,
                              enabled: isEditable,
                              maxLine: 5,
                              requestFocus: _requestFocus,
                              placeholderText: FlutterI18n.translate(context, "AddCoupon.enterExp"),
                              validator: (String value) {
                                if (value.isEmpty)
                                  return FlutterI18n.translate(context, "AddCoupon.pleaseEnterExp");
                                else
                                  return null;
                              },
                            ),
                            SizedBox(height: 28),
                            Text(FlutterI18n.translate(context, "AddCoupon.discountHeader"),
                                style: FontStyles.bigTextField(textColor: PColors.blueGrey)),
                            SizedBox(height: 8),
                            PTextField(
                              keyboardType: TextInputType.number,
                              controller: _discountController,
                              focusNode: discountFocus,
                              requestFocus: _requestFocus,
                              enabled: isEditable,
                              placeholderText: FlutterI18n.translate(context, "AddCoupon.discountHeader"),
                            ),
                            SizedBox(height: 28),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          FlutterI18n.translate(context, "AddCoupon.countHeader"),
                                          style: FontStyles.bigTextField(textColor: PColors.blueGrey),
                                        ),
                                        SizedBox(height: 8),
                                        PTextField(
                                          controller: _countController,
                                          focusNode: countFocus,
                                          requestFocus: _requestFocus,
                                          enabled: isEditable,
                                          keyboardType: TextInputType.number,
                                          placeholderText: FlutterI18n.translate(context, "AddCoupon.countHeader"),
                                        )
                                      ],
                                    )),
                                SizedBox(width: 16),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          FlutterI18n.translate(context, "DetailOfCoupon.leftCount"),
                                          style: FontStyles.bigTextField(textColor: PColors.blueGrey),
                                        ),
                                        SizedBox(height: 8),
                                        PTextField(
                                          controller: _leftCountController,
                                          focusNode: leftCountFocus,
                                          requestFocus: _requestFocus,
                                          enabled: isEditable,
                                          keyboardType: TextInputType.number,
                                          placeholderText: FlutterI18n.translate(context, "AddCoupon.leftCount"),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 28),
                            Text(FlutterI18n.translate(context, "AddCoupon.startDateHeader"),
                                style: FontStyles.bigTextField(textColor: PColors.blueGrey)),
                            SizedBox(height: 8),
                            GestureDetector(
                              onTap: () async {
                                var date = await DatePicker.showSimpleDatePicker(
                                  context,
                                  initialDate: startDate ?? DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: endDate ?? DateTime(2033),
                                  dateFormat: "dd-MMMM-yyyy",
                                  locale: DateTimePickerLocale.en_us,
                                  looping: true,
                                );

                                if (date != null) {
                                  setState(() {
                                    startDate = date;
                                    _startDateController.text = f.format(startDate);
                                  });
                                }
                              },
                              child: AbsorbPointer(
                                absorbing: true,
                                child: PTextField(
                                  controller: _startDateController,
                                  focusNode: startDateFocus,
                                  enabled: false,
                                  requestFocus: _requestFocus,
                                  placeholderText: FlutterI18n.translate(context, "AddCoupon.placeholderStartDate"),
                                  validator: (String value) {
                                    if (value.isEmpty)
                                      return FlutterI18n.translate(context, "AddCoupon.placeholderStartDate");
                                    else
                                      return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 28),
                            Text(FlutterI18n.translate(context, "AddCoupon.endDateHeader"),
                                style: FontStyles.bigTextField(textColor: PColors.blueGrey)),
                            SizedBox(height: 8),
                            GestureDetector(
                              onTap: () async {
                                var date = await DatePicker.showSimpleDatePicker(
                                  context,
                                  initialDate: endDate ?? DateTime.now(),
                                  firstDate: startDate ?? DateTime.now(),
                                  lastDate: DateTime(2030),
                                  dateFormat: "dd-MMMM-yyyy",
                                  locale: DateTimePickerLocale.en_us,
                                  looping: true,
                                );

                                if (date != null) {
                                  setState(() {
                                    endDate = date;
                                    _endDateController.text = f.format(endDate);
                                  });
                                }
                              },
                              child: AbsorbPointer(
                                absorbing: true,
                                child: PTextField(
                                  controller: _endDateController,
                                  focusNode: endDateFocus,
                                  enabled: false,
                                  requestFocus: _requestFocus,
                                  placeholderText: FlutterI18n.translate(context, "AddCoupon.placeholderEndDate"),
                                  validator: (String value) {
                                    if (value.isEmpty)
                                      return FlutterI18n.translate(context, "AddCoupon.placeholderEndDate");
                                    else
                                      return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      : Loading(),
                ),
              ),
            )
          ])
        ],
      ),
    );
  }
}
