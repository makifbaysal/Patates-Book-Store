import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/molecules/dialog.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/enums/dialog_action_state.dart';
import 'package:app/models/user_provider.dart';
import 'package:app/screens/order_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

class CreditCartBox extends StatelessWidget {
  final String cartID;
  final String cartNumber;
  final String date;
  final String owner;
  final bool isActive;
  final Function onPressed;
  final IconData icon;
  final bool isSelectable;
  final Function(String) showSnackBar;
  final bool isVertical;

  CreditCartBox(
      {Key key,
      this.cartNumber,
      this.date,
      this.owner,
      this.isActive = false,
      this.cartID,
      this.onPressed,
      this.icon,
      this.isSelectable,
      this.showSnackBar,
      this.isVertical = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        margin: isVertical ? EdgeInsets.only(bottom: 16) : EdgeInsets.only(right: 16),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        height: 120,
        width: isVertical ? null : MediaQuery.of(context).size.width * 0.70,
        decoration: BoxDecoration(
          color: isActive ? PColors.green1 : PColors.cardDark,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    cartNumber,
                    style: FontStyles.header(textColor: PColors.white),
                  ),
                ),
                Consumer<UserProvider>(
                    builder: (context, model, child) => GestureDetector(
                          onTap: () async {
                            final action = await OPDialog.yesAbortDialog(context, FlutterI18n.translate(context, "CreditCardBox.deleteCard"),
                                FlutterI18n.translate(context, "CreditCardBox.yes"), FlutterI18n.translate(context, "CreditCardBox.no"),
                                color: PColors.red);
                            if (action == DialogActionState.Yes) {
                              await model.deleteCreditCart(cartID);
                              if (model.state == ServerState.Success) {
                                showSnackBar(FlutterI18n.translate(context, "CreditCardBox.deleted"));
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(FlutterI18n.translate(context, "CreditCardBox.failed")),
                                ));
                              }
                            }
                          },
                          child: Icon(icon, color: PColors.white, size: 20),
                        ))
              ],
            ),
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        date,
                        style: FontStyles.smallTextRegular(textColor: PColors.white),
                      ),
                      Text(
                        owner,
                        style: FontStyles.textField(textColor: PColors.white),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -12,
                  right: -5,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrderCart(cartID: cartID)));
                    },
                    child: Icon(
                      int.parse(cartNumber.substring(0, 1)) == 5 ? PIcons.mastercard : PIcons.visa,
                      color: PColors.white,
                      size: 50,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
