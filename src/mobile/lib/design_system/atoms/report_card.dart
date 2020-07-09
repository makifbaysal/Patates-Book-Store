import 'package:flutter/material.dart';

import '../font_styles.dart';
import '../p_colors.dart';

class ReportCard extends StatelessWidget {
  final String header;
  final String count;
  final Color color;

  const ReportCard({Key key, @required this.header, @required this.count, @required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            header,
            style: FontStyles.text(textColor: PColors.white),
          ),
          Text(
            count,
            style: FontStyles.bookHeader(),
          )
        ],
      ),
    );
  }
}
