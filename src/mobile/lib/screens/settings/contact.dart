import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/p_text_field.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

class SettingsContact extends StatefulWidget {
  final Function showSnackBar;

  const SettingsContact({Key key, this.showSnackBar}) : super(key: key);

  @override
  _SettingsContactState createState() => _SettingsContactState();
}

class _SettingsContactState extends State<SettingsContact> {
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  FocusNode subjectFocusNode = new FocusNode();
  FocusNode messageFocusNode = new FocusNode();

  GlobalKey<FormState> formKey = new GlobalKey();

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();

    subjectFocusNode.dispose();
    messageFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "SettingsContact.header"),
            style: FontStyles.header(),
          )
        ],
      ),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    FlutterI18n.translate(context, "SettingsContact.subject"),
                    style: FontStyles.header(textColor: PColors.new_primary_button_b_y_ire_m),
                  ),
                  SizedBox(height: 12),
                  PTextField(
                    controller: _subjectController,
                    focusNode: subjectFocusNode,
                    requestFocus: _requestFocus,
                    placeholderText: FlutterI18n.translate(context, "SettingsContact.subject"),
                    maxLine: 2,
                    onPressed: () {},
                    validator: (String value) {
                      if (value.isEmpty)
                        return FlutterI18n.translate(context, "SettingsContact.enterSubject");
                      else
                        return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    FlutterI18n.translate(context, "SettingsContact.message"),
                    style: FontStyles.header(textColor: PColors.new_primary_button_b_y_ire_m),
                  ),
                  SizedBox(height: 12),
                  PTextField(
                    controller: _messageController,
                    focusNode: messageFocusNode,
                    requestFocus: _requestFocus,
                    placeholderText: FlutterI18n.translate(context, "SettingsContact.message"),
                    maxLine: 5,
                    onPressed: () {},
                    validator: (String value) {
                      if (value.isEmpty)
                        return FlutterI18n.translate(context, "SettingsContact.enterMessage");
                      else
                        return null;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 24, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Consumer<UserProvider>(
                    builder: (BuildContext context, UserProvider model, Widget child) => PButton(
                      text: FlutterI18n.translate(context, "SettingsContact.send"),
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          var response = await model.sendMessage(_messageController.text, _subjectController.text);
                          if (response == "Success") {
                            Navigator.pop(context);
                            widget.showSnackBar(FlutterI18n.translate(context, "SettingsContact.messageSuccess"));
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                              FlutterI18n.translate(context, "SettingsContact.messageFail"),
                            )));
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
