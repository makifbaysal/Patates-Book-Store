import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../font_styles.dart';
import '../p_colors.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(PColors.white),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            FlutterI18n.translate(context, "loading"),
            style: FontStyles.text(),
          )
        ],
      ),
    );
  }
}
