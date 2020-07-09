import 'package:app/design_system/icons.dart';
import 'package:app/design_system/molecules/dialog.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/dialog_action_state.dart';
import 'package:app/models/user_provider.dart';
import 'package:app/screens/product_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

import '../font_styles.dart';

class ShoppingCartCard extends StatefulWidget {
  final String id;
  final String imgUrl;
  final String bookName;
  final String author;
  final double price;
  final int count;

  ShoppingCartCard({Key key, this.imgUrl, this.bookName, this.author, this.price, this.count, this.id}) : super(key: key);

  @override
  _ShoppingCartCardState createState() => _ShoppingCartCardState();
}

class _ShoppingCartCardState extends State<ShoppingCartCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, model, child) => Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: PColors.cardDark),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                productId: widget.id,
                              ),
                            ));
                      },
                      child: Container(
                        width: 70,
                        height: 96,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: CachedNetworkImageProvider(widget.imgUrl)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.bookName,
                            overflow: TextOverflow.ellipsis,
                            style: FontStyles.bigTextField(textColor: PColors.white),
                          ),
                          SizedBox(height: 4),
                          Text(
                            widget.author,
                            style: FontStyles.textField(textColor: PColors.blueGrey),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "₺" + widget.price.toString(),
                            style: FontStyles.text(textColor: PColors.new_primary_button_b_y_ire_m),
                          ),
                          SizedBox(height: 4),
                          GestureDetector(
                            onTap: () async {
                              final action = await OPDialog.yesAbortDialog(
                                context,
                                FlutterI18n.translate(context, "ShoppingCartCard.productQues"),
                                FlutterI18n.translate(context, "yes"),
                                FlutterI18n.translate(context, "no"),
                              );
                              if (action == DialogActionState.Yes) {
                                var response = await model.deleteProductShoppingCart(widget.id);
                                if (response == "Success") {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                    FlutterI18n.translate(context, "ShoppingCartCard.productDeleted"),
                                  )));
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                    FlutterI18n.translate(context, "ShoppingCartCard.productFailed"),
                                  )));
                                }
                              }
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  PIcons.delete,
                                  size: 12,
                                  color: PColors.blueGrey,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  FlutterI18n.translate(context, "ShoppingCartCard.productRemove"),
                                  style: FontStyles.smallText(textColor: PColors.blueGrey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(PIcons.plus),
                    color: PColors.new_primary_button_b_y_ire_m,
                    onPressed: widget.count < 10
                        ? () async {
                            await model.updateShoppingCart(widget.id, 1);
                          }
                        : null,
                  ),
                  Center(
                    child: Text(
                      widget.count.toString(),
                      style: FontStyles.text(textColor: PColors.blueGrey),
                    ),
                  ),
                  IconButton(
                    icon: Icon(PIcons.minus),
                    color: PColors.new_primary_button_b_y_ire_m,
                    onPressed: () async {
                      if (widget.count > 1) {
                        await model.updateShoppingCart(widget.id, -1);
                      } else {
                        final action = await OPDialog.yesAbortDialog(
                          context,
                          FlutterI18n.translate(context, "ShoppingCartCard.productQues"),
                          FlutterI18n.translate(context, "yes"),
                          FlutterI18n.translate(context, "no"),
                        );
                        if (action == DialogActionState.Yes) {
                          var response = await model.deleteProductShoppingCart(widget.id);
                          if (response == "Success") {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                              FlutterI18n.translate(context, "ShoppingCartCard.productDeleted"),
                            )));
                          } else {
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                              FlutterI18n.translate(context, "ShoppingCartCard.productFailed"),
                            )));
                          }
                        }
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
