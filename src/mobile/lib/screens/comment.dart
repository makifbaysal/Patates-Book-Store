import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/base_widget.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/p_text_field.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Comment extends StatefulWidget {
  final String productID;
  final String commentID;
  final Function(String) showSnackBar;

  Comment({Key key, this.productID, this.showSnackBar, this.commentID}) : super(key: key);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  TextEditingController _headerController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  double star = 5;

  bool _autoValidate = false;

  FocusNode headerFocusNode = new FocusNode();
  FocusNode commentFocusNode = new FocusNode();

  CommentDetailsOutputDTO comment;

  GlobalKey<FormState> formKey = new GlobalKey();

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _commentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            widget.commentID != null ? FlutterI18n.translate(context, "Comment.edit") : FlutterI18n.translate(context, "Comment.add"),
            style: FontStyles.header(),
          )
        ],
        actions: widget.commentID != null
            ? <Widget>[
                Consumer<UserProvider>(
                  builder: (BuildContext context, model, child) => IconButton(
                    onPressed: model.state != ServerState.Busy
                        ? () async {
                            if (formKey.currentState.validate()) {
                              var dto = UpdateCommentInputDTO();
                              dto.commentId = widget.commentID;
                              dto.productId = widget.productID;
                              dto.commentHeader = _headerController.text;
                              dto.comment = _commentController.text;
                              dto.star = star;
                              await model.updateComment(dto);

                              if (model.state == ServerState.Success) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(FlutterI18n.translate(context, "Comment.editsuccess")),
                                ));
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(FlutterI18n.translate(context, "Comment.editfail")),
                                ));
                              }
                            } else {
                              setState(() {
                                _autoValidate = true;
                              });
                            }
                          }
                        : null,
                    icon: Icon(PIcons.save),
                  ),
                )
              ]
            : null,
      ),
      body: Consumer<UserProvider>(
        builder: (BuildContext context, model, Widget child) => BaseWidget<UserProvider>(onModelReady: () async {
          if (widget.commentID != null) {
            comment = await model.getCommentDetails(widget.commentID, widget.productID);
            _headerController.text = comment.commentHeader;
            _commentController.text = comment.comment;
            star = comment.star;
            setState(() {});
          }
        }, builder: (context, model, child) {
          return Form(
            key: formKey,
            autovalidate: _autoValidate,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: model.state != ServerState.Busy
                        ? ListView(
                            physics: BouncingScrollPhysics(),
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    FlutterI18n.translate(context, "Comment.star"),
                                    style: FontStyles.header(textColor: PColors.new_primary_button_b_y_ire_m),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  SmoothStarRating(
                                      allowHalfRating: false,
                                      onRated: (v) {
                                        star = v;
                                        setState(() {});
                                      },
                                      starCount: 5,
                                      rating: star,
                                      size: 40.0,
                                      filledIconData: PIcons.filledstar,
                                      halfFilledIconData: PIcons.halfstar,
                                      color: PColors.orange,
                                      borderColor: PColors.orange,
                                      spacing: 0.0),
                                  SizedBox(height: 32),
                                  Text(
                                    FlutterI18n.translate(context, "Comment.header"),
                                    style: FontStyles.header(textColor: PColors.new_primary_button_b_y_ire_m),
                                  ),
                                  SizedBox(height: 12),
                                  PTextField(
                                    controller: _headerController,
                                    focusNode: headerFocusNode,
                                    requestFocus: _requestFocus,
                                    placeholderText: FlutterI18n.translate(context, "Comment.addHeader"),
                                    maxLine: 1,
                                    onPressed: () {},
                                    validator: (String value) {
                                      if (value.isEmpty)
                                        return FlutterI18n.translate(context, "Comment.addHeader");
                                      else
                                        return null;
                                    },
                                  ),
                                  SizedBox(height: 32),
                                  Text(
                                    FlutterI18n.translate(context, "Comment.comment"),
                                    style: FontStyles.header(textColor: PColors.new_primary_button_b_y_ire_m),
                                  ),
                                  SizedBox(height: 12),
                                  PTextField(
                                    controller: _commentController,
                                    focusNode: commentFocusNode,
                                    requestFocus: _requestFocus,
                                    placeholderText: FlutterI18n.translate(context, "Comment.comment"),
                                    maxLine: 6,
                                    onPressed: () {},
                                    validator: (String value) {
                                      if (value.isEmpty)
                                        return FlutterI18n.translate(context, "Comment.comment");
                                      else
                                        return null;
                                    },
                                  )
                                ],
                              ),
                            ],
                          )
                        : Loading(),
                  ),
                  widget.commentID == null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            PButton(
                              onPressed: () async {
                                if (formKey.currentState.validate()) {
                                  var response = await model.makeComment(widget.productID, _headerController.text, _commentController.text, star);
                                  if (response == "Error") {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text(
                                      FlutterI18n.translate(context, "Comment.commentSuccess"),
                                    )));
                                  } else {
                                    Navigator.pop(context);
                                    widget.showSnackBar(FlutterI18n.translate(context, "Comment.commentSuccess"));
                                  }
                                }
                              },
                              text: FlutterI18n.translate(context, "Comment.add"),
                            )
                          ],
                        )
                      : SizedBox(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
