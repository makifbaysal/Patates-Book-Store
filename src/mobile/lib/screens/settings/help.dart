import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/user_provider.dart';
import 'package:app/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

import 'contact.dart';

class SettingsHelp extends StatefulWidget {
  @override
  _SettingsHelpState createState() => _SettingsHelpState();
}

class _SettingsHelpState extends State<SettingsHelp> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  showSnackBar(String message) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (context, model, child) => Scaffold(
            key: _scaffoldKey,
            backgroundColor: PColors.darkBackground,
            appBar: PAppBar(
              isCenter: true,
              children: <Widget>[
                Text(
                  FlutterI18n.translate(context, "SettingsHelp.header"),
                  style: FontStyles.header(),
                )
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: PColors.cardDark,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.settingsFaq);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    PIcons.faq,
                                    color: PColors.blueGrey,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    FlutterI18n.translate(context, "Faq.header"),
                                    style: FontStyles.bigTextField(textColor: PColors.blueGrey),
                                  ),
                                ],
                              ),
                              Icon(
                                PIcons.rightarrow,
                                color: PColors.blueGrey,
                              ),
                            ],
                          ),
                        ), //account
                        SizedBox(height: 20),
                        model.idToken != null
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SettingsContact(
                                                showSnackBar: showSnackBar,
                                              )));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          PIcons.contact,
                                          color: PColors.blueGrey,
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          FlutterI18n.translate(context, "SettingsContact.header"),
                                          style: FontStyles.bigTextField(textColor: PColors.blueGrey),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      PIcons.rightarrow,
                                      color: PColors.blueGrey,
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
