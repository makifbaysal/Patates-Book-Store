import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/product_provider.dart';
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

import '../../router.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: PColors.darkBackground,
        appBar: PAppBar(
          isCenter: true,
          children: <Widget>[
            Text(
              FlutterI18n.translate(context, "Settings.header"),
              style: FontStyles.header(),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(color: PColors.cardDark, borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
              child: model.idToken != null
                  ? Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.settingsAccount);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(PIcons.account, color: PColors.blueGrey),
                                  SizedBox(width: 20),
                                  Text(
                                    FlutterI18n.translate(context, "Settings.account"),
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
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.settingsOrders);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    PIcons.box,
                                    color: PColors.blueGrey,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    FlutterI18n.translate(context, "Settings.orders"),
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
                        ), //orders
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.settingsAddresses);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    color: PColors.blueGrey,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    FlutterI18n.translate(context, "Settings.addresses"),
                                    style: FontStyles.bigTextField(textColor: PColors.blueGrey),
                                  ),
                                ],
                              ),
                              Icon(
                                PIcons.rightarrow,
                                color: PColors.blueGrey,
                              )
                            ],
                          ),
                        ), //addresses
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.myCards);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.credit_card,
                                    color: PColors.blueGrey,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    FlutterI18n.translate(context, "Settings.cards"),
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
                        ), //cards
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.settingsComments);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.comment,
                                    color: PColors.blueGrey,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    FlutterI18n.translate(context, "Settings.comments"),
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
                        ), //comments
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.settingsCouponCodes);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    PIcons.couponcode,
                                    color: PColors.blueGrey,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    FlutterI18n.translate(context, "Settings.coupon_codes"),
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
                        ), //coupon codes
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.settingsHelp);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    PIcons.help,
                                    color: PColors.blueGrey,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    FlutterI18n.translate(context, "Settings.help"),
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
                        ), //help
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.settingsAbout);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    PIcons.info,
                                    color: PColors.blueGrey,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    FlutterI18n.translate(context, "Settings.about"),
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
                            Navigator.pushNamed(context, Routes.settingsSettings);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    PIcons.settings,
                                    color: PColors.blueGrey,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    FlutterI18n.translate(context, "Settings.settings"),
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
                    )
                  : Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.settingsHelp);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    PIcons.help,
                                    color: PColors.blueGrey,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    FlutterI18n.translate(context, "Settings.help"),
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
                        ), //help
                        SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.settingsAbout);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    PIcons.info,
                                    color: PColors.blueGrey,
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    FlutterI18n.translate(context, "Settings.about"),
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
                        SizedBox(height: 12),
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
            model.idToken != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 16, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Consumer2<UserProvider, ProductProvider>(
                          builder: (BuildContext context, UserProvider model, ProductProvider productProvider, Widget child) => PButton(
                            color: PColors.red,
                            text: FlutterI18n.translate(context, "Settings.logout"),
                            icon: PIcons.logout,
                            onPressed: () async {
                              await model.logout();
                              await productProvider.clearCompareProducts();
                              Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
                            },
                          ),
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 16, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        PButton(
                            text: FlutterI18n.translate(context, "Login.header"),
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.login);
                            })
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
