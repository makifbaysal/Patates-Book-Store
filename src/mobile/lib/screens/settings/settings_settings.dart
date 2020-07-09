import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/molecules/dialog.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/dialog_action_state.dart';
import 'package:app/models/product_provider.dart';
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

import '../../router.dart';

class SettingsSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "Settings.settings"),
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
              padding: EdgeInsets.all(24),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.settingsNotifications);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              PIcons.notifications,
                              color: PColors.blueGrey,
                            ),
                            SizedBox(width: 20),
                            Text(
                              FlutterI18n.translate(context, "Settings.notifications"),
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
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.settingsUpdatePassword);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              PIcons.updatepassword,
                              color: PColors.blueGrey,
                            ),
                            SizedBox(width: 20),
                            Text(
                              FlutterI18n.translate(context, "Settings.updatePassword"),
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
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.settingsLanguage);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              PIcons.language,
                              color: PColors.blueGrey,
                            ),
                            SizedBox(width: 20),
                            Text(
                              FlutterI18n.translate(context, "Settings.languages"),
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
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Consumer2<UserProvider, ProductProvider>(
                  builder: (BuildContext context, UserProvider model, provider, Widget child) => PButton(
                    color: PColors.red,
                    text: FlutterI18n.translate(context, "Settings.deleteAccount"),
                    onPressed: () async {
                      final action = await OPDialog.yesAbortDialog(context, FlutterI18n.translate(context, "Settings.ensureDeletingAccount"),
                          FlutterI18n.translate(context, "yes"), FlutterI18n.translate(context, "no"),
                          color: PColors.red);
                      if (action == DialogActionState.Yes) {
                        await model.deActiveUser();
                        await model.logout();
                        await provider.clearCompareProducts();
                        Navigator.pushNamedAndRemoveUntil(context, Routes.login, ModalRoute.withName(Routes.login));
                      }
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
