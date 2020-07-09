import 'package:flutter/material.dart';

import '../../font_styles.dart';
import '../../p_colors.dart';

class UncustomizableTextField extends StatelessWidget {
  final String placeholderText;
  final bool isDescription;

  const UncustomizableTextField({Key key, this.placeholderText, this.isDescription = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: PColors.cardLightBackground,
      ),
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: isDescription == false ? Axis.horizontal : Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  placeholderText,
                  style: FontStyles.bigTextField(textColor: PColors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
