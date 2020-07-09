import 'package:app/design_system/atoms/p_text_field.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

class SettingsUpdatePassword extends StatefulWidget {
  @override
  _SettingsUpdatePasswordState createState() => _SettingsUpdatePasswordState();
}

class _SettingsUpdatePasswordState extends State<SettingsUpdatePassword> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _newPasswordAgainController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  IconData _passwordIcon = PIcons.showpassword;
  bool _showPassword = false;
  bool _autoValidate = false;

  FocusNode oldPasswordFocusNode = new FocusNode();
  FocusNode newPasswordFocusNode = new FocusNode();
  FocusNode newPasswordAgainFocusNode = new FocusNode();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordAgainController.dispose();

    oldPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    newPasswordAgainFocusNode.dispose();

    super.dispose();
  }

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: AppBar(
        backgroundColor: PColors.cardDark,
        centerTitle: true,
        title: Text(
          FlutterI18n.translate(context, "SettingsUpdatePassword.header"),
          style: FontStyles.header(textColor: PColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Form(
                key: formKey,
                autovalidate: _autoValidate,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    Text(FlutterI18n.translate(context, "SettingsUpdatePassword.oldPassword"),
                        style: FontStyles.bigTextField(textColor: PColors.white)),
                    SizedBox(height: 12),
                    PTextField(
                      focusNode: oldPasswordFocusNode,
                      controller: _oldPasswordController,
                      requestFocus: _requestFocus,
                      placeholderText: FlutterI18n.translate(context, "SettingsUpdatePassword.enterOldPassword"),
                      keyboardType: TextInputType.visiblePassword,
                      showPassword: _showPassword,
                      suffixIcon: _passwordIcon,
                      validator: (String value) {
                        if (value.isEmpty) return FlutterI18n.translate(context, "Login.ErrorMessages.password.pleaseEnterPassword");
                        if (value.length < 6)
                          return FlutterI18n.translate(context, "Login.ErrorMessages.password.enterValidPassword");
                        else
                          return null;
                      },
                      onPressed: () {
                        if (!_showPassword) {
                          setState(() {
                            _passwordIcon = PIcons.hidepassword;
                            _showPassword = true;
                          });
                        } else {
                          setState(() {
                            _passwordIcon = PIcons.showpassword;
                            _showPassword = false;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    Text(FlutterI18n.translate(context, "SettingsUpdatePassword.newPassword"),
                        style: FontStyles.bigTextField(textColor: PColors.white)),
                    SizedBox(height: 12),
                    PTextField(
                      focusNode: newPasswordFocusNode,
                      controller: _newPasswordController,
                      requestFocus: _requestFocus,
                      placeholderText: FlutterI18n.translate(context, "SettingsUpdatePassword.enterNewPassword"),
                      keyboardType: TextInputType.visiblePassword,
                      showPassword: _showPassword,
                      suffixIcon: _passwordIcon,
                      validator: (String value) {
                        if (value.isEmpty) return FlutterI18n.translate(context, "Login.ErrorMessages.password.pleaseEnterPassword");
                        if (value.length < 6)
                          return FlutterI18n.translate(context, "Login.ErrorMessages.password.enterValidPassword");
                        else
                          return null;
                      },
                      onPressed: () {
                        if (!_showPassword) {
                          setState(() {
                            _passwordIcon = PIcons.hidepassword;
                            _showPassword = true;
                          });
                        } else {
                          setState(() {
                            _passwordIcon = PIcons.showpassword;
                            _showPassword = false;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    Text(FlutterI18n.translate(context, "SettingsUpdatePassword.newPasswordAgain"),
                        style: FontStyles.bigTextField(textColor: PColors.white)),
                    SizedBox(height: 12),
                    PTextField(
                      focusNode: newPasswordAgainFocusNode,
                      controller: _newPasswordAgainController,
                      requestFocus: _requestFocus,
                      placeholderText: FlutterI18n.translate(context, "SettingsUpdatePassword.enterNewPasswordAgain"),
                      keyboardType: TextInputType.visiblePassword,
                      showPassword: _showPassword,
                      suffixIcon: _passwordIcon,
                      validator: (String value) {
                        if (value.isEmpty)
                          return FlutterI18n.translate(context, "Login.ErrorMessages.password.pleaseEnterPassword");
                        else if (value.length < 6)
                          return FlutterI18n.translate(context, "Login.ErrorMessages.password.enterValidPassword");
                        else if (_newPasswordController.text != value)
                          return FlutterI18n.translate(context, "SettingsUpdatePassword.passwordNotMatch");
                        else
                          return null;
                      },
                      onPressed: () {
                        if (!_showPassword) {
                          setState(() {
                            _passwordIcon = PIcons.hidepassword;
                            _showPassword = true;
                          });
                        } else {
                          setState(() {
                            _passwordIcon = PIcons.showpassword;
                            _showPassword = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Consumer<UserProvider>(
              builder: (BuildContext context, UserProvider model, Widget child) => PButton(
                text: FlutterI18n.translate(context, "SettingsUpdatePassword.update"),
                onPressed: () async {
                  if (formKey.currentState.validate()) {
                    String response = await model.updateUserPassword(_newPasswordController.text, _oldPasswordController.text);
                    if (response == "Success") {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                        FlutterI18n.translate(context, "SettingsUpdatePassword.successPasswordUpdate"),
                      )));
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                        FlutterI18n.translate(context, "SettingsUpdatePassword.errorPasswordUpdate"),
                      )));
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
