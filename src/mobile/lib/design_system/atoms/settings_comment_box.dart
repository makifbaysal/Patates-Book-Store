import 'package:app/design_system/icons.dart';
import 'package:app/design_system/molecules/dialog.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/enums/dialog_action_state.dart';
import 'package:app/models/user_provider.dart';
import 'package:app/screens/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

import '../font_styles.dart';

class SettingsCommentBox extends StatelessWidget {
  final String header;
  final String comment;
  final double star;
  final bool isGeneral;
  final String name;
  final String productID;
  final String commentID;
  final Function snackBar;

  SettingsCommentBox({Key key, this.header, this.comment, this.star, this.isGeneral, this.name, this.productID, this.commentID, this.snackBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider model = Provider.of<UserProvider>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PColors.cardDark,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        header,
                        style: FontStyles.bigTextField(textColor: isGeneral ? PColors.new_primary_button_b_y_ire_m : PColors.white),
                      ),
                    ),
                    SizedBox(width: 8),
                    isGeneral == false
                        ? Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Comment(
                                                productID: productID,
                                                commentID: commentID,
                                              )));
                                },
                                child: Icon(
                                  PIcons.edit,
                                  color: PColors.white,
                                ),
                              ),
                              SizedBox(width: 8),
                              GestureDetector(
                                onTap: () async {
                                  final action = await OPDialog.yesAbortDialog(
                                      context,
                                      FlutterI18n.translate(context, "Comments.confirm"),
                                      FlutterI18n.translate(context, "yes"),
                                      FlutterI18n.translate(context, "no"),
                                      color: PColors.red);
                                  if (action == DialogActionState.Yes) {
                                    await model.deleteComment(commentID, productID);
                                    if (model.state == ServerState.Success) {
                                      snackBar(content: Text(
                                        FlutterI18n.translate(context, "Comments.success"),
                                      ));
                                    } else {
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text(
                                        FlutterI18n.translate(context, "Comments.error"),
                                      )));
                                    }
                                  }
                                },
                                child: Icon(
                                  PIcons.delete,
                                  color: PColors.red,
                                ),
                              )
                            ],
                          )
                        : SizedBox()
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  comment,
                  style: FontStyles.text(textColor: isGeneral ? PColors.white : PColors.blueGrey),
                ),
              )
            ],
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < star ? PIcons.filledstar : PIcons.emptystar,
                    color: PColors.orange,
                  );
                }),
              ),
              Text(
                name,
                style: FontStyles.smallTextRegular(textColor: PColors.blueGrey),
              )
            ],
          )
        ],
      ),
    );
  }
}
