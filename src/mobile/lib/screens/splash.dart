import 'package:app/design_system/organisms/splash_screen.dart';
import 'package:app/models/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../router.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (BuildContext context, UserProvider model, Widget child) => SplashScreen(
          seconds: 2,
          navigateAfterSeconds: model.idToken == null ? Routes.login : model.isAdmin ? Routes.admin.adminHome : Routes.home,
          title: Text('Patates'),
          image: Image(
            image: CachedNetworkImageProvider('https://stickershop.line-scdn.net/stickershop/v1/product/1300822/LINEStorePC/main.png;compress=true'),
          ),
          backgroundColor: Colors.white,
          styleTextUnderTheLoader: new TextStyle(),
          photoSize: 100.0,
          loaderColor: Colors.blue),
    );
  }
}
