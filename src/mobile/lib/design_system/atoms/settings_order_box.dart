import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../font_styles.dart';
import '../p_colors.dart';

class SettingsOrderBox extends StatelessWidget {
  final String orderNo;
  final String date;
  final int quantity;
  final double total;
  final String situation;
  final VoidCallback onPressed;

  const SettingsOrderBox({Key key, this.orderNo, this.date, this.quantity, this.total, this.situation, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: PColors.cardDark,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  FlutterI18n.translate(context, "SettingsOrderBox.orderNum") + orderNo,
                  style: FontStyles.text(textColor: PColors.white),
                  overflow: TextOverflow.ellipsis,
                ),
//                Text(
//                  date,
//                  style: FontStyles.smallTextRegular(textColor: PColors.blueGrey),
//                )
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  FlutterI18n.translate(context, "SettingsOrderBox.productNum") + quantity.toString(),
                  style: FontStyles.smallText(textColor: PColors.white),
                ),
                Text(
                  FlutterI18n.translate(context, "SettingsOrderBox.orderAmount") + total.toStringAsFixed(2),
                  style: FontStyles.smallTextRegular(textColor: PColors.white),
                )
              ],
            ),
            SizedBox(height: 12),
            situation != null
                ? Text(
                    FlutterI18n.translate(context, situation),
                    style: FontStyles.smallText(textColor: PColors.new_primary_button_b_y_ire_m),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
