import 'package:app/design_system/p_colors.dart';
import 'package:flutter/material.dart';

import '../../font_styles.dart';

class AdminHomeCard extends StatelessWidget {
  final Color boxColor;
  final IconData boxIcon;
  final String text;
  final VoidCallback onPressed;

  const AdminHomeCard({Key key, this.boxColor, this.boxIcon, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: boxColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(boxIcon, size: 52, color: PColors.white),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                    Expanded(child: Text(text, style: FontStyles.header())),
                    Icon(Icons.keyboard_arrow_right, size: 25, color: PColors.white),
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
