import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../font_styles.dart';
import '../p_colors.dart';

class Or extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1,
          width: 60,
          color: PColors.blueGrey,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            FlutterI18n.translate(context, "or"),
            style: FontStyles.smallText(textColor: PColors.blueGrey),
          ),
        ),
        Container(
          height: 1,
          width: 60,
          color: PColors.blueGrey,
        ),
      ],
    );
  }
}
