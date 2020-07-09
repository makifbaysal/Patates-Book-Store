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
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class SettingsAddressDetails extends StatefulWidget {
  final String addressID;
  bool isEditable;
  final Function(String) showSnackBar;

  SettingsAddressDetails({Key key, this.addressID, this.isEditable = false, this.showSnackBar}) : super(key: key);

  @override
  _SettingsAddressDetailsState createState() => _SettingsAddressDetailsState();
}

class _SettingsAddressDetailsState extends State<SettingsAddressDetails> {
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
        leading: widget.isEditable
            ? IconButton(
                onPressed: () {
                  _addressHeaderController.text = addressDetail.header;
                  _addressController.text = addressDetail.address;
                  _countyController.text = addressDetail.county;
                  _cityController.text = addressDetail.city;
                  _zipCodeController.text = addressDetail.zipcode;
                  setState(() {
                    widget.isEditable = false;
                  });
                },
                icon: Icon(Icons.clear),
              )
            : null,
        children: <Widget>[
          Text(
            widget.isEditable
                ? FlutterI18n.translate(context, "OrderAddress.editAddress")
                : FlutterI18n.translate(context, "OrderAddress.detailOfAddress"),
            style: FontStyles.header(),
          )
        ],
        actions: widget.isEditable
            ? <Widget>[
                Consumer<UserProvider>(
                  builder: (BuildContext context, model, child) => IconButton(
                    onPressed: model.state != ServerState.Busy
                        ? () async {
                            if (formKey.currentState.validate()) {
                              var updateAddressInputDTO = UpdateAddressInputDTO();
                              updateAddressInputDTO.addressId = widget.addressID;
                              updateAddressInputDTO.header = _addressHeaderController.text;
                              updateAddressInputDTO.address = _addressController.text;
                              updateAddressInputDTO.city = _cityController.text;
                              updateAddressInputDTO.county = _countyController.text;
                              updateAddressInputDTO.zipcode = _zipCodeController.text;
                              //await model.updateAddress(updateAddressInputDTO);
                              if (model.state == ServerState.Success) {
                                setState(() {
                                  widget.isEditable = false;
                                });
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(FlutterI18n.translate(context, "OrderAddress.updateAddressSuccess")),
                                ));
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(FlutterI18n.translate(context, "OrderAddress.updateAddressError")),
                                ));
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
                Consumer<UserProvider>(
                  builder: (context, model, child) => IconButton(
                    onPressed: () async {
                      final action = await OPDialog.yesAbortDialog(context, FlutterI18n.translate(context, "OrderAddress.ensureDeleteAddress"),
                          FlutterI18n.translate(context, "yes"), FlutterI18n.translate(context, "no"),
                          color: PColors.red);
                      if (action == DialogActionState.Yes) {
                        await model.deleteAddress(widget.addressID);
                        if (model.state == ServerState.Success) {
                          Navigator.pop(context);
                          widget.showSnackBar(FlutterI18n.translate(context, "OrderAddress.deleteAddressSuccess"));
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(FlutterI18n.translate(context, "OrderAddress.deleteAddressError")),
                          ));
                        }
                      }
                    },
                    icon: Icon(PIcons.delete, color: PColors.red, size: 25),
                  ),
                )
              ],
      ),
      body: Consumer<UserProvider>(
        builder: (BuildContext context, model, Widget child) => BaseWidget<UserProvider>(
          onModelReady: () async {
            addressDetail = await model.getAddressDetail(widget.addressID);
            _addressHeaderController.text = addressDetail.header;
            _addressController.text = addressDetail.address;
            _cityController.text = addressDetail.city;
            _countyController.text = addressDetail.county;
            _zipCodeController.text = addressDetail.zipcode;
            setState(() {});
          },
          builder: (context, model, child) {
            if (addressDetail != null) {
              return Form(
                key: formKey,
                autovalidate: _autoValidate,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(20),
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
                            enabled: widget.isEditable,
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
                            enabled: widget.isEditable,
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
                                      enabled: widget.isEditable,
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
                                      enabled: widget.isEditable,
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
                            enabled: widget.isEditable,
                            requestFocus: _requestFocus,
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
                    )
                  ],
                ),
              );
            }
            return Loading();
          },
        ),
      ),
    );
  }
}
