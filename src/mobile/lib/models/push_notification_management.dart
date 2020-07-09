import 'dart:async';
import 'dart:io';

import 'package:app/utils/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotification extends ChangeNotifier {
  final SharedPreferences pref;
  final FirebaseMessaging fcm = FirebaseMessaging();
  StreamSubscription iOSSubscription;

  bool subscribeAll = true;
  bool subscribeProducts = true;

  PushNotification({this.pref});

  initialize() {
    subscribeAll = pref.getBool(Constants.notificationAll) ?? true;
    if (subscribeAll) {
      subscribeToTopic('allUser', Constants.notificationAll);
    }
    subscribeProducts = pref.getBool(Constants.notificationProduct) ?? true;
    if (subscribeProducts) {
      subscribeToTopic('newBook', Constants.notificationProduct);
    }

    if (Platform.isIOS) {
      iOSSubscription = fcm.onIosSettingsRegistered.listen((data) {});

      fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  subscribeToTopic(String topic, String key) {
    fcm.subscribeToTopic(topic);
    pref.setBool(key, true);
  }

  unsubscribeFromTopic(String topic, String key) {
    fcm.unsubscribeFromTopic(topic);
    pref.setBool(key, false);
  }

  cancelIOSSubscription() {
    iOSSubscription.cancel();
  }
}
