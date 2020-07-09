import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/base_widget.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

class SettingsLanguage extends StatefulWidget {
  @override
  _SettingsLanguageState createState() => _SettingsLanguageState();
}

class _SettingsLanguageState extends State<SettingsLanguage> {
  int groupValue;

  void radio(int e, LanguageProvider model) {
    setState(() {
      if (e == 0) {
        groupValue = 0;
        model.setLanguage("tr");
      } else if (e == 1) {
        groupValue = 1;
        model.setLanguage("en");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "Settings.languages"),
            style: FontStyles.header(),
          )
        ],
      ),
      body: Consumer<LanguageProvider>(
        builder: (BuildContext context, LanguageProvider model, Widget child) => BaseWidget<LanguageProvider>(
          model: model,
          onModelReady: () {
            if (model.langCode == "tr") {
              groupValue = 0;
            } else {
              groupValue = 1;
            }
          },
          builder: (BuildContext context, LanguageProvider model, Widget child) => Padding(
            padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(24, 24, 0, 24),
                  decoration: BoxDecoration(
                    color: PColors.cardDark,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: PColors.blueGrey,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Türkçe",
                                  style: FontStyles.header(textColor: PColors.blueGrey),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Radio(
                                  onChanged: (int e) {
                                    radio(e, model);
                                  },
                                  activeColor: PColors.green1,
                                  value: 0,
                                  groupValue: groupValue,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: PColors.blueGrey,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "English",
                                  style: FontStyles.header(textColor: PColors.blueGrey),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Radio(
                                  onChanged: (int e) {
                                    radio(e, model);
                                  },
                                  activeColor: PColors.green1,
                                  value: 1,
                                  groupValue: groupValue,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
