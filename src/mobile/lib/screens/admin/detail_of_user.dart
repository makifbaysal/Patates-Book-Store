import 'package:app/design_system/atoms/admin/add_photo_card.dart';
import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/admin/uncustomizable_text_field.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/molecules/dialog.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/enums/dialog_action_state.dart';
import 'package:app/models/user_provider.dart';
import 'package:app/screens/admin/customer_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class DetailOfUser extends StatelessWidget {
  final AdminGetUserDetailsOutputDTO user;
  final Function(String) showSnackBar;

  const DetailOfUser({Key key, this.user, this.showSnackBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[Text(FlutterI18n.translate(context, "DetailOfUser.header"), style: FontStyles.header())],
        actions: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdminCustomerDetails(orders: user.orders, amount: user.totalAmount)));
              },
              child: Icon(Icons.account_circle))
        ],
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.all(20),
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Row(
                children: <Widget>[
                  AddPhotoCard(
                    icon: PIcons.account,
                    isEditable: false,
                    imageURL: user.imageUrl,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text(FlutterI18n.translate(context, "DetailOfUser.nameSurnameHeader"), style: FontStyles.header(textColor: PColors.blueGrey)),
                        SizedBox(height: 8),
                        Container(
                          height: 61,
                          child: UncustomizableTextField(
                            placeholderText: user.name,
                          ),
                        ),
                        SizedBox(height: 28),
                        Text(
                          FlutterI18n.translate(context, "DetailOfUser.emailHeader"),
                          style: FontStyles.header(textColor: PColors.blueGrey),
                        ),
                        SizedBox(height: 8),
                        Container(
                            height: 61,
                            child: UncustomizableTextField(
                              placeholderText: user.email,
                            )),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Text(FlutterI18n.translate(context, "DetailOfUser.phoneHeader"), style: FontStyles.header(textColor: PColors.blueGrey)),
              SizedBox(height: 8),
              Container(
                height: 60,
                child: UncustomizableTextField(placeholderText: user.phone ?? FlutterI18n.translate(context, "DetailOfUser.phoneWarning")),
              ),
            ],
          ),
          Positioned(
            bottom: 32,
            left: 20,
            right: 20,
            child: Consumer<UserProvider>(
              builder: (context, model, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  PButton(
                    text: FlutterI18n.translate(context, "DetailOfUser.resetPassword"),
                    onPressed: () async {
                      final action = await OPDialog.yesAbortDialog(context, FlutterI18n.translate(context, "DetailOfUser.askResetPasswordMail"),
                          FlutterI18n.translate(context, "yes"), FlutterI18n.translate(context, "no"),
                          color: PColors.red);
                      if (action == DialogActionState.Yes) {
                        await model.resetPassword(user.email);
                        if (model.state == ServerState.Success) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                            FlutterI18n.translate(context, "DetailOfUser.sentResetMail"),
                          )));
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                            FlutterI18n.translate(context, "DetailOfUser.errorResetMail"),
                          )));
                        }
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  PButton(
                    color: PColors.red,
                    text: FlutterI18n.translate(context, "DetailOfUser.deleteAccount"),
                    onPressed: () async {
                      final action = await OPDialog.yesAbortDialog(context, FlutterI18n.translate(context, "DetailOfUser.askDeleteUser"),
                          FlutterI18n.translate(context, "yes"), FlutterI18n.translate(context, "no"),
                          color: PColors.red);
                      if (action == DialogActionState.Yes) {
                        await model.deActiveUser(user: user.id);
                        if (model.state == ServerState.Success) {
                          Navigator.pop(context);
                          showSnackBar(FlutterI18n.translate(context, "DetailOfUser.successDelete"));
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                            FlutterI18n.translate(context, "DetailOfUser.errorDelete"),
                          )));
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
