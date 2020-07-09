import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/push_notification_management.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

class SettingsNotifications extends StatefulWidget {
  @override
  _SettingsNotificationsState createState() => _SettingsNotificationsState();
}

class _SettingsNotificationsState extends State<SettingsNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "SettingsNotifications.header"),
            style: FontStyles.header(),
          )
        ],
      ),
      body: Consumer<PushNotification>(
        builder: (BuildContext context, PushNotification model, Widget child) => Padding(
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(24, 24, 0, 24),
                  decoration: BoxDecoration(
                    color: PColors.cardDark,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        FlutterI18n.translate(context, "SettingsNotifications.appNotf"),
                        style: FontStyles.header(textColor: PColors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: PColors.blueGrey,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  FlutterI18n.translate(context, "SettingsNotifications.campaigns"),
                                  style: FontStyles.header(textColor: PColors.blueGrey),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Switch(
                                activeColor: PColors.new_primary_button_b_y_ire_m,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: model.subscribeAll,
                                onChanged: (bool value) {
                                  setState(() {
                                    model.subscribeAll = value;
                                    if (value) {
                                      setState(() {
                                        model.subscribeToTopic("allUser", Constants.notificationAll);
                                      });
                                    } else {
                                      setState(() {
                                        model.unsubscribeFromTopic("allUser", Constants.notificationAll);
                                      });
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: PColors.blueGrey,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  FlutterI18n.translate(context, "SettingsNotifications.newBooks"),
                                  style: FontStyles.header(textColor: PColors.blueGrey),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Switch(
                                activeColor: PColors.new_primary_button_b_y_ire_m,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: model.subscribeProducts,
                                onChanged: (bool value) {
                                  setState(() {
                                    model.subscribeProducts = value;
                                    if (value) {
                                      setState(() {
                                        model.subscribeToTopic("newBook", Constants.notificationProduct);
                                      });
                                    } else {
                                      setState(() {
                                        model.unsubscribeFromTopic("newBook", Constants.notificationProduct);
                                      });
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
