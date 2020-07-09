import 'package:flutter/material.dart';

import '../../font_styles.dart';
import '../../p_colors.dart';

class OrderManagementTopBar extends StatelessWidget {
  final bool isActive;
  final String header;
  final VoidCallback onPressed;

  const OrderManagementTopBar({Key key, @required this.isActive, @required this.header, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          decoration: isActive ? BoxDecoration(color: PColors.new_primary_button_b_y_ire_m, borderRadius: BorderRadius.circular(8)) : null,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            header,
            style: FontStyles.smallText(textColor: PColors.white),
          )),
    );
  }
}
