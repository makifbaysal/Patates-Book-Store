import 'package:flutter/material.dart';

import '../font_styles.dart';
import '../p_colors.dart';

class SelectableBox extends StatefulWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const SelectableBox({Key key, this.text, this.isSelected = false, this.onPressed}) : super(key: key);

  @override
  _SelectableBoxState createState() => _SelectableBoxState();
}

class _SelectableBoxState extends State<SelectableBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: widget.isSelected == false ? PColors.cardLightBackground : PColors.new_primary_button_b_y_ire_m,
        ),
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Text(
          widget.text,
          style: FontStyles.smallText(textColor: PColors.white),
        ),
      ),
    );
  }
}
