import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/p_text_field.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class AdminAccount extends StatefulWidget {
  @override
  _AdminAccountState createState() => _AdminAccountState();
}

class _AdminAccountState extends State<AdminAccount> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode nameFocusNode = new FocusNode();
  FocusNode emailFocusNode = new FocusNode();
  FocusNode phoneFocusNode = new FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider model = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "Settings.account"),
            style: FontStyles.header(),
          )
        ],
      ),
      body: FutureBuilder(
        future: model.getUserDetail(),
        builder: (BuildContext context, AsyncSnapshot<UserDetailsOutputDTO> snapshot) {
          if (snapshot.hasData) {
            if (nameController != null) {
              nameController.text = snapshot.data.name;
            }
            if (emailController != null) {
              emailController.text = snapshot.data.email;
            }
            if (phoneController != null) {
              phoneController.text = snapshot.data.phone;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(color: PColors.cardDark, borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 92,
                          width: 92,
                          decoration: BoxDecoration(
                            color: PColors.blueGrey,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Icon(
                            PIcons.account,
                            color: PColors.cardDark,
                            size: 35,
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              snapshot.data.name,
                              style: FontStyles.header(),
                            ),
                            SizedBox(height: 12),
                            Text(
                              snapshot.data.email,
                              style: FontStyles.text(textColor: PColors.blueGrey),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 28, 32, 28),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: <Widget>[
                                Text(FlutterI18n.translate(context, "SignUp.nameSurname"), style: FontStyles.bigTextField(textColor: PColors.white)),
                                SizedBox(height: 8),
                                PTextField(
                                  focusNode: nameFocusNode,
                                  controller: nameController,
                                  placeholderText: FlutterI18n.translate(context, "SignUp.ErrorMessages.nameSurname.enterNameSurname"),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return FlutterI18n.translate(context, "SignUp.ErrorMessages.nameSurname.pleaseEnterNameSurname");
                                    } else if (value.split(" ").length < 2) {
                                      return FlutterI18n.translate(context, "SignUp.ErrorMessages.nameSurname.enterValidNameSurname");
                                    }
                                  },
                                ),
                                SizedBox(height: 28),
                                Text(FlutterI18n.translate(context, "SignUp.email"), style: FontStyles.bigTextField(textColor: PColors.white)),
                                SizedBox(height: 8),
                                PTextField(
                                    focusNode: emailFocusNode,
                                    controller: emailController,
                                    placeholderText: FlutterI18n.translate(context, "SignUp.ErrorMessages.email.enterEmail"),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return FlutterI18n.translate(context, "SignUp.ErrorMessages.nameSurname.pleaseEnterEmail");
                                      }
                                      Pattern pattern =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value)) return FlutterI18n.translate(context, "Login.ErrorMessages.email.enterValidEmail");
                                    }),
                                SizedBox(height: 28),
                                Text(FlutterI18n.translate(context, "Account.phone"), style: FontStyles.bigTextField(textColor: PColors.white)),
                                SizedBox(height: 8),
                                PTextField(
                                    focusNode: phoneFocusNode,
                                    controller: phoneController,
                                    keyboardType: TextInputType.number,
                                    placeholderText: FlutterI18n.translate(context, "Account.enterPhone"),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return FlutterI18n.translate(context, "Account.pleaseEnterPhone");
                                      }
                                      Pattern pattern = r'^(05(\d{9}))$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value))
                                        return FlutterI18n.translate(context, FlutterI18n.translate(context, "Account.enterValidPhone"));
                                    }),
                              ],
                            ),
                          ),
                          PButton(
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                var response = await model.updateUser(nameController.text, emailController.text, phoneController.text);
                                if (response == "Success") {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                    FlutterI18n.translate(context, "Account.successUpdate"),
                                  )));
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                    FlutterI18n.translate(context, "Account.errorSuccess"),
                                  )));
                                }
                              }
                            },
                            text: FlutterI18n.translate(context, "Account.update"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Loading();
        },
      ),
    );
  }
}
