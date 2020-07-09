import 'dart:ui' as ui;

import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  final SharedPreferences pref;
  FlutterI18nDelegate flutterI18nDelegate;
  String langCode;

  setLanguage(String langCode) {
    if (langCode == "tr") {
      flutterI18nDelegate = FlutterI18nDelegate(
        useCountryCode: false,
        fallbackFile: "tr",
        path: 'assets/i18n',
        forcedLocale: Locale("tr"),
      );
      pref.setString(Constants.language, "tr");
      this.langCode = "tr";
    } else {
      flutterI18nDelegate = FlutterI18nDelegate(
        useCountryCode: false,
        fallbackFile: "en",
        path: 'assets/i18n',
        forcedLocale: Locale("en"),
      );
      pref.setString(Constants.language, "en");
      this.langCode = "en";
    }
    notifyListeners();
  }

  LanguageProvider({this.pref}) {
    langCode = pref.getString(Constants.language) ?? ui.window.locale.languageCode;
    setLanguage(langCode);
  }
}
