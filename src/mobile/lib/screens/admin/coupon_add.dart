import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/p_text_field.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CouponAdd extends StatefulWidget {
  final Function showSnackBar;

  const CouponAdd({Key key, this.showSnackBar}) : super(key: key);

  @override
  _CouponAddState createState() => _CouponAddState();
}

class _CouponAddState extends State<CouponAdd> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _discountController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _countController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime startDate;
  DateTime endDate;

  final f = new DateFormat('dd/MM/yyyy');
  bool _autoValidate = false;

  FocusNode nameFocus = new FocusNode();
  FocusNode codeFocus = new FocusNode();
  FocusNode discountFocus = new FocusNode();
  FocusNode startDateFocus = new FocusNode();
  FocusNode endDateFocus = new FocusNode();
  FocusNode countFocus = new FocusNode();
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
    _descriptionController.dispose();

    nameFocus.dispose();
    codeFocus.dispose();
    discountFocus.dispose();
    startDateFocus.dispose();
    endDateFocus.dispose();
    countFocus.dispose();
    descriptionFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AdminProvider model = Provider.of<AdminProvider>(context);
    return Scaffold(
        backgroundColor: PColors.darkBackground,
        appBar: PAppBar(
          isCenter: true,
          children: <Widget>[Text(FlutterI18n.translate(context, "AddCoupon.headerAdd"), style: FontStyles.header())],
          actions: <Widget>[
            GestureDetector(
              onTap: () async {
                if (formKey.currentState.validate()) {
                  await model.addCoupon(
                      code: _codeController.text,
                      description: _descriptionController.text,
                      expireTime: endDate,
                      startTime: startDate,
                      header: _nameController.text,
                      lowerLimit: 50,
                      percentageDiscount: double.parse(_discountController.text),
                      remainingQuantity: int.parse(_countController.text),
                      startQuantity: int.parse(_countController.text));
                  Navigator.pop(context);
                  widget.showSnackBar(FlutterI18n.translate(context, "AddCoupon.successAdd"));
                }
              },
              child: Icon(PIcons.save),
            )
          ],
        ),
        body: Form(
          key: formKey,
          autovalidate: _autoValidate,
          child: ListView(
            padding: EdgeInsets.all(20),
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(FlutterI18n.translate(context, "AddCoupon.nameHeader"), style: FontStyles.header(textColor: PColors.blueGrey)),
                        SizedBox(
                          height: 8,
                        ),
                        PTextField(
                          controller: _nameController,
                          focusNode: nameFocus,
                          requestFocus: _requestFocus,
                          placeholderText: FlutterI18n.translate(context, "AddCoupon.placeholderName"),
                          validator: (String value) {
                            if (value.isEmpty)
                              return FlutterI18n.translate(context, "AddCoupon.placeholderName");
                            else
                              return null;
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(FlutterI18n.translate(context, "AddCoupon.codeHeader"), style: FontStyles.header(textColor: PColors.blueGrey)),
                        SizedBox(
                          height: 8,
                        ),
                        PTextField(
                          controller: _codeController,
                          focusNode: codeFocus,
                          requestFocus: _requestFocus,
                          placeholderText: FlutterI18n.translate(context, "AddCoupon.placeholderCode"),
                          validator: (String value) {
                            if (value.isEmpty)
                              return FlutterI18n.translate(context, "AddCoupon.placeholderCode");
                            else
                              return null;
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(FlutterI18n.translate(context, "AddCoupon.exp"), style: FontStyles.header(textColor: PColors.blueGrey)),
                        SizedBox(
                          height: 8,
                        ),
                        PTextField(
                          controller: _descriptionController,
                          focusNode: descriptionFocus,
                          maxLine: 5,
                          requestFocus: _requestFocus,
                          placeholderText: FlutterI18n.translate(context, "AddCoupon.pleaseEnterExp"),
                          validator: (String value) {
                            if (value.isEmpty)
                              return FlutterI18n.translate(context, "AddCoupon.pleaseEnterExp");
                            else
                              return null;
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(FlutterI18n.translate(context, "AddCoupon.discountHeader"), style: FontStyles.header(textColor: PColors.blueGrey)),
                        SizedBox(height: 8),
                        PTextField(
                          controller: _discountController,
                          focusNode: discountFocus,
                          requestFocus: _requestFocus,
                          keyboardType: TextInputType.number,
                          placeholderText: FlutterI18n.translate(context, "AddCoupon.placeholderDiscount"),
                          validator: (String value) {
                            if (value.isEmpty)
                              return FlutterI18n.translate(context, "AddCoupon.placeholderDiscount");
                            else if (double.parse(value) < 1)
                              return FlutterI18n.translate(context, "AddCoupon.discountValidation");
                            else if (double.parse(value) > 100)
                              return FlutterI18n.translate(context, "AddCoupon.discountValidationGreater");
                            else
                              return null;
                          },
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
                        Text(FlutterI18n.translate(context, "AddCoupon.countHeader"), style: FontStyles.header(textColor: PColors.blueGrey)),
                        SizedBox(
                          height: 8,
                        ),
                        PTextField(
                          controller: _countController,
                          focusNode: countFocus,
                          requestFocus: _requestFocus,
                          keyboardType: TextInputType.number,
                          placeholderText: FlutterI18n.translate(context, "AddCoupon.placeholderCount"),
                          validator: (String value) {
                            if (value.isEmpty)
                              return FlutterI18n.translate(context, "AddCoupon.placeholderCount");
                            else if (int.parse(value) < 1)
                              return FlutterI18n.translate(context, "AddCoupon.usageValidation");
                            else
                              return null;
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(FlutterI18n.translate(context, "AddCoupon.startDateHeader"), style: FontStyles.header(textColor: PColors.blueGrey)),
                        SizedBox(
                          height: 8,
                        ),
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(FlutterI18n.translate(context, "AddCoupon.endDateHeader"), style: FontStyles.header(textColor: PColors.blueGrey)),
                        SizedBox(
                          height: 8,
                        ),
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
