import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class SettingsAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "About.header"),
            style: FontStyles.header(),
          )
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(24),
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage("assets/images/irem.jpeg"), fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Software Project Manager",
                        style: FontStyles.bigTextField(textColor: PColors.new_primary_button_b_y_ire_m),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "İrem Dereli",
                        style: FontStyles.text(textColor: PColors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            PIcons.github,
                            size: 13,
                            color: PColors.blueGrey,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "github.com/iremdereli",
                            style: FontStyles.smallTextRegular(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Container(height: 1.0, color: PColors.blueGrey),
          SizedBox(height: 16),
          Row(
            children: <Widget>[
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage("assets/images/akif.jpg"), fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Software Configuration Manager",
                        style: FontStyles.bigTextField(textColor: PColors.new_primary_button_b_y_ire_m),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Mehmet Akif Baysal",
                        style: FontStyles.text(textColor: PColors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            PIcons.github,
                            size: 13,
                            color: PColors.blueGrey,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "github.com/play0sm",
                            style: FontStyles.smallTextRegular(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Container(height: 1.0, color: PColors.blueGrey),
          SizedBox(height: 16),
          Row(
            children: <Widget>[
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage("assets/images/sezer.jpg"), fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Software Architect",
                        style: FontStyles.bigTextField(textColor: PColors.new_primary_button_b_y_ire_m),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Mehmet Sezer",
                        style: FontStyles.text(textColor: PColors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            PIcons.github,
                            size: 13,
                            color: PColors.blueGrey,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "github.com/mhmtszr",
                            style: FontStyles.smallTextRegular(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Container(height: 1.0, color: PColors.blueGrey),
          SizedBox(height: 16),
          Row(
            children: <Widget>[
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage("assets/images/guney.jpeg"), fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Software Tester",
                        style: FontStyles.bigTextField(textColor: PColors.new_primary_button_b_y_ire_m),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Güney Kırık",
                        style: FontStyles.text(textColor: PColors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            PIcons.github,
                            size: 13,
                            color: PColors.blueGrey,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "github.com/kirikguney",
                            style: FontStyles.smallTextRegular(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Container(height: 1.0, color: PColors.blueGrey),
          SizedBox(height: 16),
          Row(
            children: <Widget>[
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage("assets/images/ilkan.jpg"), fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Software Analyst",
                        style: FontStyles.bigTextField(textColor: PColors.new_primary_button_b_y_ire_m),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "İlkan Akın Erenler",
                        style: FontStyles.text(textColor: PColors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            PIcons.github,
                            size: 13,
                            color: PColors.blueGrey,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "github.com/ilkanakin",
                            style: FontStyles.smallTextRegular(),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
