import 'package:app/design_system/atoms/p_text_field.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

import '../router.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _nameSurnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordAgainController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _autoValidate = false;

  IconData _passwordIcon = PIcons.showpassword;

  bool _showPassword = false;

  FocusNode nameSurnameFocusNode = new FocusNode();
  FocusNode emailFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();
  FocusNode passwordAgainFocusNode = new FocusNode();

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    _nameSurnameController.dispose();
    _emailController.dispose();
    _passwordAgainController.dispose();
    _passwordController.dispose();

    nameSurnameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordAgainFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PColors.darkBackground,
        body: Form(
          key: formKey,
          autovalidate: _autoValidate,
          child: ListView(
            padding: EdgeInsets.fromLTRB(32, 65, 32, 24),
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Center(
                child: Text(
                  FlutterI18n.translate(context, "SignUp.header"),
                  style: FontStyles.header(),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              PTextField(
                controller: _nameSurnameController,
                focusNode: nameSurnameFocusNode,
                requestFocus: _requestFocus,
                validator: (String value) {
                  if (value.isEmpty) return FlutterI18n.translate(context, "SignUp.ErrorMessages.nameSurname.pleaseEnterNameSurname");
                  if (value.split(" ").length < 2)
                    return FlutterI18n.translate(context, "SignUp.ErrorMessages.nameSurname.enterValidNameSurname");
                  else
                    return null;
                },
                keyboardType: TextInputType.text,
                placeholderText: FlutterI18n.translate(context, "SignUp.nameSurname"),
              ),
              SizedBox(
                height: 16,
              ),
              PTextField(
                controller: _emailController,
                focusNode: emailFocusNode,
                requestFocus: _requestFocus,
                keyboardType: TextInputType.emailAddress,
                validator: (String value) {
                  Pattern pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = new RegExp(pattern);
                  if (value.isEmpty) return FlutterI18n.translate(context, "SignUp.ErrorMessages.email.pleaseEnterEmail");
                  if (!regex.hasMatch(value))
                    return FlutterI18n.translate(context, "SignUp.ErrorMessages.email.enterValidEmail");
                  else
                    return null;
                },
                placeholderText: FlutterI18n.translate(context, "SignUp.email"),
              ),
              SizedBox(
                height: 16,
              ),
              PTextField(
                controller: _passwordController,
                focusNode: passwordFocusNode,
                requestFocus: _requestFocus,
                keyboardType: TextInputType.visiblePassword,
                placeholderText: FlutterI18n.translate(context, "SignUp.password"),
                showPassword: _showPassword,
                validator: (String value) {
                  if (value.isEmpty) return FlutterI18n.translate(context, "SignUp.ErrorMessages.password.pleaseEnterPassword");
                  if (value.length < 6)
                    return FlutterI18n.translate(context, "SignUp.ErrorMessages.password.enterValidPassword");
                  else
                    return null;
                },
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
                height: 16,
              ),
              PTextField(
                controller: _passwordAgainController,
                focusNode: passwordAgainFocusNode,
                requestFocus: _requestFocus,
                keyboardType: TextInputType.visiblePassword,
                validator: (String value) {
                  if (value.isEmpty) return FlutterI18n.translate(context, "SignUp.ErrorMessages.password.pleaseEnterPassword");
                  if (value.length < 6) return FlutterI18n.translate(context, "SignUp.ErrorMessages.password.enterValidPassword");
                  if (value != _passwordController.text)
                    return FlutterI18n.translate(context, "SignUp.ErrorMessages.password.passwordDoesNotMatch");
                  else
                    return null;
                },
                placeholderText: FlutterI18n.translate(context, "SignUp.passwordAgain"),
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
              Consumer<UserProvider>(
                builder: (BuildContext context, UserProvider model, Widget child) => PButton(
                  text: FlutterI18n.translate(context, "SignUp.signUp"),
                  loading: model.state == ServerState.Busy,
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      CreateUserInputDTO createUserInputDTO = new CreateUserInputDTO();
                      createUserInputDTO.email = _emailController.text;
                      createUserInputDTO.password = _passwordController.text;
                      createUserInputDTO.name = _nameSurnameController.text;
                      model.signUp(createUserInputDTO).whenComplete(() {
                        if (model.state == ServerState.Success) {
                          Navigator.pushNamedAndRemoveUntil(context, Routes.home, ModalRoute.withName(Routes.home));
                          model.setState(ServerState.Idle);
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                            FlutterI18n.translate(context, "SignUp.userAlreadyExist"),
                          )));
                        }
                      });
                    } else {
                      setState(() {
                        _autoValidate = true;
                      });
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
                    Navigator.pushReplacementNamed(context, Routes.login);
                  },
                  child: RichText(
                      text: new TextSpan(children: [
                    new TextSpan(text: FlutterI18n.translate(context, "SignUp.doYouHaveAccount"), style: FontStyles.text()),
                    new TextSpan(text: " " + FlutterI18n.translate(context, "SignUp.login"), style: FontStyles.text(textColor: PColors.white)),
                  ])),
                ),
              )
            ],
          ),
        ));
  }
}
