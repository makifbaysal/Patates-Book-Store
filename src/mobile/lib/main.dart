import 'dart:async';
import 'dart:convert';

import 'package:app/design_system/p_colors.dart';
import 'package:app/models/language_provider.dart';
import 'package:app/models/product_provider.dart';
import 'package:app/models/push_notification_management.dart';
import 'package:app/router.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/admin_provider.dart';
import 'models/shipping_provider.dart';
import 'models/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();

  Crashlytics.instance.enableInDevMode = true;

  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runZoned<Future<void>>(() async {
    return runApp(MyApp(sharedPreferences: pref));
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({Key key, this.sharedPreferences}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );

    String username = 'username';
    String password = 'password';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));

    defaultApiClient.addDefaultHeader(
      "Authorization",
      basicAuth,
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PushNotification>(create: (_) => PushNotification(pref: widget.sharedPreferences)),
        ChangeNotifierProvider<LanguageProvider>(create: (_) => LanguageProvider(pref: widget.sharedPreferences)),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider(pref: widget.sharedPreferences)),
        ChangeNotifierProvider<ProductProvider>(create: (_) => ProductProvider()),
        ChangeNotifierProvider<ShippingProvider>(create: (_) => ShippingProvider()),
        ChangeNotifierProvider<AdminProvider>(create: (_) => AdminProvider()),
      ],
      child: Consumer2<LanguageProvider, PushNotification>(builder: (BuildContext context, model, notificationProvider, Widget child) {
        notificationProvider.initialize();
        return MaterialApp(
          title: 'Patates',
          supportedLocales: [
            Locale('en', 'US'),
            Locale('tr', 'TR'),
          ],
          locale: Locale(model.langCode),
          theme: ThemeData(
            canvasColor: PColors.cardDark,
            appBarTheme: AppBarTheme(elevation: 0.0, color: Colors.black12), //elevation did work
            inputDecorationTheme: InputDecorationTheme(border: UnderlineInputBorder()),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          onGenerateRoute: generateRoute,
          localizationsDelegates: [
            model.flutterI18nDelegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      }),
    );
  }
}
