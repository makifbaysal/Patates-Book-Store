import 'package:flutter/material.dart';

import '../font_styles.dart';
import '../p_colors.dart';

class Faq extends StatelessWidget {
  final String question;
  final String answer;

  const Faq({Key key, this.question, this.answer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: PColors.cardDark, borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            question,
            style: FontStyles.text(textColor: PColors.new_primary_button_b_y_ire_m),
          ),
          SizedBox(height: 12),
          Text(
            answer,
            style: FontStyles.textField(textColor: PColors.white),
          )
        ],
      ),
    );
  }
}
