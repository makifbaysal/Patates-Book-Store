import 'package:flutter/material.dart';

import '../../font_styles.dart';
import '../../p_colors.dart';

class LittleReportCard extends StatelessWidget {
  final String header;
  final String count;
  final IconData icon;
  final String miniHeader;

  const LittleReportCard({Key key, @required this.header, @required this.count, @required this.icon, this.miniHeader}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                color: PColors.green1,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
              ),
              height: 70,
              width: 70,
              child: Center(
                child: Icon(
                  icon,
                  size: 60,
                  color: PColors.white,
                ),
              )),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: PColors.cardDark,
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
                ),
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      header,
                      style: FontStyles.text(textColor: PColors.white),
                    ),
                    SizedBox(height: 4),
                    miniHeader != null
                        ? Text(
                            miniHeader + " - " + count,
                            style: FontStyles.header(textColor: PColors.white),
                          )
                        : Text(
                            count,
                            style: FontStyles.header(textColor: PColors.white),
                          ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

// iremiko
