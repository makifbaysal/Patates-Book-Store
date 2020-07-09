import 'package:app/design_system/atoms/or.dart';
import 'package:app/design_system/atoms/p_text_field.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/molecules/pdialog.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

import '../router.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _autoValidate = false;

  IconData _passwordIcon = PIcons.showpassword;

  bool _showPassword = false;

  FocusNode emailFocusNode = new FocusNode();
  FocusNode resetPasswordEmailFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void initState() {
    _emailController.text = "m.szr98@gmail.com";
    _passwordController.text = "123456";
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: formKey,
        autovalidate: _autoValidate,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.fromLTRB(32, 65, 32, 24),
          children: <Widget>[
            Center(
              child: Text(
                FlutterI18n.translate(context, "Login.header"),
                style: FontStyles.header(),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            PTextField(
              controller: _emailController,
              focusNode: emailFocusNode,
              validator: (String value) {
                Pattern pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regex = new RegExp(pattern);
                if (value.isEmpty) return FlutterI18n.translate(context, "Login.ErrorMessages.email.pleaseEnterEmail");
                if (!regex.hasMatch(value))
                  return FlutterI18n.translate(context, "Login.ErrorMessages.email.enterValidEmail");
                else
                  return null;
              },
              requestFocus: _requestFocus,
              keyboardType: TextInputType.emailAddress,
              placeholderText: FlutterI18n.translate(context, "Login.email"),
            ),
            SizedBox(
              height: 16,
            ),
            PTextField(
              controller: _passwordController,
              focusNode: passwordFocusNode,
              requestFocus: _requestFocus,
              keyboardType: TextInputType.visiblePassword,
              placeholderText: FlutterI18n.translate(context, "Login.password"),
              validator: (String value) {
                if (value.isEmpty) return FlutterI18n.translate(context, "Login.ErrorMessages.password.pleaseEnterPassword");
                if (value.length < 6)
                  return FlutterI18n.translate(context, "Login.ErrorMessages.password.enterValidPassword");
                else
                  return null;
              },
              showPassword: _showPassword,
              suffixIcon: _passwordIcon,
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
            SizedBox(
              height: 24,
            ),
            GestureDetector(
              child: Center(
                  child: Text(
                FlutterI18n.translate(context, "Login.forgetPassword"),
                style: FontStyles.text(),
              )),
              onTapDown: (_) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    TextEditingController _resetPasswordEmailController = TextEditingController();
                    GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();
                    bool _resetAutoValidate = false;
                    return PDialog(
                      children: <Widget>[
                        Text(FlutterI18n.translate(context, "Login.enterEmail"), style: FontStyles.bigTextField()),
                        SizedBox(
                          height: 32,
                        ),
                        Form(
                          key: resetFormKey,
                          autovalidate: _resetAutoValidate,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              PTextField(
                                controller: _resetPasswordEmailController,
                                focusNode: resetPasswordEmailFocusNode,
                                requestFocus: _requestFocus,
                                keyboardType: TextInputType.emailAddress,
                                validator: (String value) {
                                  Pattern pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regex = new RegExp(pattern);
                                  if (value.isEmpty) return FlutterI18n.translate(context, "Login.ErrorMessages.email.pleaseEnterEmail");
                                  if (!regex.hasMatch(value))
                                    return FlutterI18n.translate(context, "Login.ErrorMessages.email.enterValidEmail");
                                  else
                                    return null;
                                },
                                placeholderText: FlutterI18n.translate(context, "Login.email"),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Consumer<UserProvider>(
                                builder: (BuildContext context, UserProvider model, Widget child) => PButton(
                                  text: FlutterI18n.translate(context, "Login.sentResetMail"),
                                  color: model.state != ServerState.Error ? PColors.new_primary_button_b_y_ire_m : PColors.red,
                                  loading: model.state == ServerState.Busy,
                                  onPressed: () async {
                                    if (resetFormKey.currentState.validate()) {
                                      resetFormKey.currentState.save();
                                      model.resetPassword(_resetPasswordEmailController.text).whenComplete(() {
                                        if (model.state == ServerState.Success) {
                                          Navigator.pop(context);
                                          model.setState(ServerState.Idle);
                                        } else {
                                          Scaffold.of(context).showSnackBar(SnackBar(
                                              content: Text(
                                            FlutterI18n.translate(context, "Login.userNotExist"),
                                          )));
                                        }
                                      });
                                    } else {
                                      setState(() {
                                        _resetAutoValidate = true;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            ),
            SizedBox(
              height: 24,
            ),
            Consumer<UserProvider>(
              builder: (BuildContext context, UserProvider model, Widget child) => PButton(
                text: FlutterI18n.translate(context, "Login.login"),
                loading: model.state == ServerState.Busy,
                onPressed: () async {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    LoginInputDTO loginInputDTO = new LoginInputDTO();
                    loginInputDTO.email = _emailController.text;
                    loginInputDTO.password = _passwordController.text;
                    await model.login(loginInputDTO);
                    if (model.state == ServerState.Success) {
                      if (model.isAdmin) {
                        Navigator.pushNamedAndRemoveUntil(context, Routes.admin.adminHome, ModalRoute.withName(Routes.admin.adminHome));
                      } else {
                        Navigator.pushNamedAndRemoveUntil(context, Routes.home, ModalRoute.withName(Routes.home));
                      }
                      model.setState(ServerState.Idle);
                    } else {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            FlutterI18n.translate(context, "Login.wrongUserNameOrPassword"),
                          ),
                        ),
                      );
                    }
                  } else {
                    setState(
                      () {
                        _autoValidate = true;
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Center(
              child: GestureDetector(
                onTapDown: (_) {
                  Navigator.pushReplacementNamed(context, Routes.signUp);
                },
                child: RichText(
                  text: new TextSpan(
                    children: [
                      new TextSpan(text: FlutterI18n.translate(context, "Login.doNotYouHaveAccount"), style: FontStyles.text()),
                      new TextSpan(
                          text: " " + FlutterI18n.translate(context, "Login.createAccount"), style: FontStyles.text(textColor: PColors.white)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Or(),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Center(
                child: Text(
                  FlutterI18n.translate(context, "Login.withoutUser"),
                  style: FontStyles.text(),
                ),
              ),
              onTapDown: (_) {
                Navigator.pushReplacementNamed(context, Routes.home);
              },
            ),
          ],
        ),
      ),
    );
  }
}
