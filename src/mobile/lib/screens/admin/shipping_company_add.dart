import 'dart:io';

import 'package:app/design_system/atoms/admin/add_photo_card.dart';
import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/base_widget.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/p_text_field.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/molecules/dialog.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/enums/dialog_action_state.dart';
import 'package:app/models/shipping_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class ShippingCompanyAdd extends StatefulWidget {
  final String companyId;
  bool isEditable;
  final Function(String) showSnackBar;

  ShippingCompanyAdd({Key key, this.companyId, this.isEditable = false, this.showSnackBar}) : super(key: key);

  @override
  _ShippingCompanyAddState createState() => _ShippingCompanyAddState();
}

class _ShippingCompanyAddState extends State<ShippingCompanyAdd> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _websiteController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  File imageFile;
  String imgURL;
  DateTime dateTime;
  final f = new DateFormat('dd.MM.yyyy');

  bool _autoValidate = false;

  FocusNode nameFocusNode = new FocusNode();
  FocusNode phoneFocusNode = new FocusNode();
  FocusNode websiteFocusNode = new FocusNode();
  FocusNode endDateFocusNode = new FocusNode();
  FocusNode priceFocusNode = new FocusNode();
  ShippingCompanyDetailsOutputDTO shippingCompanyDetail;

  GlobalKey<FormState> formKey = new GlobalKey();

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    _endDateController.dispose();
    _priceController.dispose();

    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    websiteFocusNode.dispose();
    endDateFocusNode.dispose();
    priceFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
          isCenter: true,
          leading: widget.isEditable && widget.companyId != null
              ? IconButton(
                  onPressed: () {
                    _nameController.text = shippingCompanyDetail.name;
                    _phoneController.text = shippingCompanyDetail.contactNumber;
                    _websiteController.text = shippingCompanyDetail.website;
                    _endDateController.text = shippingCompanyDetail.endDate.toString();
                    _priceController.text = shippingCompanyDetail.price.toString();
                    imgURL = shippingCompanyDetail.imageUrl;
                    setState(() {
                      widget.isEditable = false;
                    });
                  },
                  icon: Icon(Icons.clear),
                )
              : null,
          children: <Widget>[
            Text(
                FlutterI18n.translate(
                    context,
                    widget.isEditable
                        ? widget.companyId == null ? "AddShippingCompany.header" : FlutterI18n.translate(context, "AddShippingCompany.update")
                        : FlutterI18n.translate(context, "AddShippingCompany.show")),
                style: FontStyles.header())
          ],
          actions: widget.isEditable
              ? <Widget>[
                  Consumer<ShippingProvider>(
                    builder: (BuildContext context, model, child) => IconButton(
                      onPressed: model.state != ServerState.Busy
                          ? () async {
                              if (formKey.currentState.validate()) {
                                if (widget.companyId != null) {
                                  await model.updateShippingCompany(widget.companyId, _nameController.text, double.parse(_priceController.text),
                                      _websiteController.text, _phoneController.text, dateTime);
                                  if (model.state == ServerState.Success) {
                                    if (imageFile != null) {
                                      await model.updatePhotoShippingCompany(widget.companyId, imageFile);
                                    }
                                  }
                                  if (model.state == ServerState.Success) {
                                    setState(() {
                                      widget.isEditable = false;
                                    });
                                    Scaffold.of(context)
                                        .showSnackBar(SnackBar(content: Text(FlutterI18n.translate(context, "AddShippingCompany.successUpdate"))));
                                  } else {
                                    Scaffold.of(context)
                                        .showSnackBar(SnackBar(content: Text(FlutterI18n.translate(context, "AddShippingCompany.errorUpdate"))));
                                  }
                                } else {
                                  if (imageFile != null && dateTime != null) {
                                    await model.addShippingCompany(_websiteController.text, double.parse(_priceController.text), _nameController.text,
                                        dateTime, _phoneController.text, imageFile);
                                    if (model.state == ServerState.Success) {
                                      Navigator.pop(context);
                                      widget.showSnackBar(FlutterI18n.translate(context, "AddShippingCompany.successAdd"));
                                    } else {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text(FlutterI18n.translate(context, "AddShippingCompany.errorAdd")),
                                      ));
                                    }
                                  } else if (dateTime == null) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(FlutterI18n.translate(context, "AddShippingCompany.pleaseSelectDate")),
                                    ));
                                  } else {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(FlutterI18n.translate(context, "AddShippingCompany.pleaseSelectImage")),
                                    ));
                                  }
                                }
                              } else {
                                setState(() {
                                  _autoValidate = true;
                                });
                              }
                            }
                          : null,
                      icon: Icon(PIcons.save),
                    ),
                  )
                ]
              : <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.isEditable = true;
                      });
                    },
                    icon: Icon(PIcons.edit, color: PColors.white, size: 25),
                  ),
                  Consumer<ShippingProvider>(
                    builder: (context, model, child) => IconButton(
                      onPressed: () async {
                        final action = await OPDialog.yesAbortDialog(context, FlutterI18n.translate(context, "AddShippingCompany.ensureCompany"),
                            FlutterI18n.translate(context, "yes"), FlutterI18n.translate(context, "no"),
                            color: PColors.red);
                        if (action == DialogActionState.Yes) {
                          await model.deleteShippingCompany(widget.companyId);
                          if (model.state == ServerState.Success) {
                            Navigator.pop(context);
                            widget.showSnackBar(FlutterI18n.translate(context, "AddShippingCompany.successDelete"));
                          } else {
                            Scaffold.of(context)
                                .showSnackBar(SnackBar(content: Text(FlutterI18n.translate(context, "AddShippingCompany.errorDelete"))));
                          }
                        }
                      },
                      icon: Icon(PIcons.delete, color: PColors.red, size: 25),
                    ),
                  )
                ]),
      body: Consumer<ShippingProvider>(
        builder: (context, shippingProvider, child) => BaseWidget<ShippingProvider>(
          model: shippingProvider,
          onModelReady: () async {
            if (widget.companyId != null) {
              shippingCompanyDetail = await shippingProvider.getShippingCompanyDetails(widget.companyId);
              if (shippingProvider.state == ServerState.Success) {
                _nameController.text = shippingCompanyDetail.name;
                _phoneController.text = shippingCompanyDetail.contactNumber;
                dateTime = shippingCompanyDetail.endDate;
                _endDateController.text = f.format(shippingCompanyDetail.endDate);
                _priceController.text = shippingCompanyDetail.price.toString();
                _websiteController.text = shippingCompanyDetail.website;
                imgURL = shippingCompanyDetail.imageUrl;
                setState(() {});
              }
            }
          },
          builder: (context, model, child) => shippingProvider.state != ServerState.Busy
              ? Form(
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
                            child: AddPhotoCard(
                              isEditable: widget.isEditable,
                              onPressed: () async {
                                var img = await ImagePicker.pickImage(source: ImageSource.camera);
                                setState(() {
                                  imageFile = img;
                                });
                              },
                              image: imageFile,
                              imageURL: imgURL,
                              icon: PIcons.addpicture,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10),
                                Text(
                                  FlutterI18n.translate(context, "AddShippingCompany.nameHeader"),
                                  style: FontStyles.header(textColor: PColors.blueGrey),
                                ),
                                SizedBox(height: 8),
                                PTextField(
                                  enabled: widget.isEditable,
                                  controller: _nameController,
                                  focusNode: nameFocusNode,
                                  requestFocus: _requestFocus,
                                  placeholderText: FlutterI18n.translate(context, "AddShippingCompany.placeholderName"),
                                  onPressed: () {},
                                  validator: (String value) {
                                    if (value.isEmpty)
                                      return FlutterI18n.translate(context, "AddShippingCompany.placeholderName");
                                    else
                                      return null;
                                  },
                                ),
                                SizedBox(height: 28),
                                Text(
                                  FlutterI18n.translate(context, "AddShippingCompany.phoneHeader"),
                                  style: FontStyles.header(textColor: PColors.blueGrey),
                                ),
                                SizedBox(height: 8),
                                PTextField(
                                  enabled: widget.isEditable,
                                  controller: _phoneController,
                                  focusNode: phoneFocusNode,
                                  keyboardType: TextInputType.number,
                                  requestFocus: _requestFocus,
                                  placeholderText: FlutterI18n.translate(context, "AddShippingCompany.placeholderPhone"),
                                  onPressed: () {},
                                  validator: (String value) {
                                    if (value.isEmpty)
                                      return FlutterI18n.translate(context, "AddShippingCompany.placeholderPhone");
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            FlutterI18n.translate(context, "AddShippingCompany.websiteHeader"),
                            style: FontStyles.header(textColor: PColors.blueGrey),
                          ),
                          SizedBox(height: 8),
                          PTextField(
                            enabled: widget.isEditable,
                            controller: _websiteController,
                            focusNode: websiteFocusNode,
                            requestFocus: _requestFocus,
                            placeholderText: FlutterI18n.translate(context, "AddShippingCompany.placeholderWebsite"),
                            onPressed: () {},
                            validator: (String value) {
                              if (value.isEmpty)
                                return FlutterI18n.translate(context, "AddShippingCompany.placeholderWebsite");
                              else
                                return null;
                            },
                          ),
                          SizedBox(height: 24),
                          Text(
                            FlutterI18n.translate(context, "AddShippingCompany.endDateHeader"),
                            style: FontStyles.header(textColor: PColors.blueGrey),
                          ),
                          SizedBox(height: 8),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: PColors.cardDark,
                              ),
                              child: Text(
                                dateTime != null ? f.format(dateTime) : FlutterI18n.translate(context, "AddShippingCompany.pleaseSelectDate"),
                                style: FontStyles.text(),
                              ),
                            ),
                            onTap: () async {
                              var date = await DatePicker.showSimpleDatePicker(
                                context,
                                initialDate: dateTime ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                                dateFormat: "dd-MMMM-yyyy",
                                locale: DateTimePickerLocale.en_us,
                                looping: true,
                              );

                              if (date != null) {
                                setState(() {
                                  dateTime = date;
                                });
                              }
                            },
                          ),
                          SizedBox(height: 24),
                          Text(
                            FlutterI18n.translate(context, "AddShippingCompany.agreementPrice"),
                            style: FontStyles.header(textColor: PColors.blueGrey),
                          ),
                          SizedBox(height: 8),
                          PTextField(
                            enabled: widget.isEditable,
                            controller: _priceController,
                            focusNode: priceFocusNode,
                            keyboardType: TextInputType.number,
                            requestFocus: _requestFocus,
                            placeholderText: FlutterI18n.translate(context, "AddShippingCompany.enterPrice"),
                            onPressed: () {},
                            validator: (String value) {
                              if (value.isEmpty)
                                return FlutterI18n.translate(context, "AddShippingCompany.pleaseEnterPrice");
                              else
                                return null;
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Loading(),
        ),
      ),
    );
  }
}
