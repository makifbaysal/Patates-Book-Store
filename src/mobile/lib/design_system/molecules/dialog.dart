import 'dart:ui';

import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/dialog_action_state.dart';
import 'package:flutter/material.dart';

import '../font_styles.dart';

class OPDialog {
  static Future<DialogActionState> yesAbortDialog(BuildContext context, String body, String positiveText, String negativeText, {Color color}) async {
    final action = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: PColors.darkBackground,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0),
          ),
          elevation: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 12, right: 12),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 1,
                        color: PColors.white,
                      ),
                    ),
                    Icon(
                      PIcons.info,
                      size: 90,
                      color: PColors.white,
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: PColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 50),
                child: Text(
                  body,
                  style: FontStyles.bigTextField(textColor: PColors.blueGrey),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () => Navigator.of(context).pop(DialogActionState.Yes),
                      padding: EdgeInsets.symmetric(vertical: 20),
                      color: color ?? PColors.green1,
                      child: Center(
                          child: Text(
                        positiveText,
                        style: FontStyles.text(textColor: PColors.white),
                      )),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(15)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () => Navigator.of(context).pop(DialogActionState.No),
                      padding: EdgeInsets.symmetric(vertical: 20),
                      color: PColors.cardLightBackground,
                      child: Center(
                          child: Text(
                        negativeText,
                        style: FontStyles.text(textColor: PColors.white),
                      )),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.only(bottomRight: Radius.circular(15)),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
    return (action != null) ? action : DialogActionState.Abort;
  }
}
