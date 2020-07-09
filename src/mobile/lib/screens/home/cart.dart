import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/atoms/shopping_cart_card.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/ServerState.dart';
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

import '../../router.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  FocusNode searchFocusNode = new FocusNode();
  TextEditingController _couponController = TextEditingController();
  double totalPrice = 0;

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider model = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: PColors.darkBackground,
        body: FutureBuilder(
          future: model.getShoppingCard(),
          builder: (BuildContext context, AsyncSnapshot<List<ShoppingCartProductListingOutputDTO>> snapshot) {
            totalPrice = 0;
            if (model.discountPercentage > 0) {
              _couponController.text = model.couponCode;
            }
            if (snapshot.hasData) {
              snapshot.data.forEach((element) {
                totalPrice += element.price * element.quantity;
              });
            }

            return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: snapshot.hasData
                            ? (snapshot.data.length > 0
                                ? ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return ShoppingCartCard(
                                        id: snapshot.data[index].id,
                                        imgUrl: snapshot.data[index].imageUrl,
                                        bookName: snapshot.data[index].name,
                                        author: snapshot.data[index].author,
                                        price: snapshot.data[index].price,
                                        count: snapshot.data[index].quantity,
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text(
                                      FlutterI18n.translate(context, "Cart.noProductInCart"),
                                      textAlign: TextAlign.center,
                                      style: FontStyles.text(),
                                    ),
                                  ))
                            : Loading()),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              onTap: () {
                                _requestFocus(searchFocusNode);
                              },
                              controller: _couponController,
                              autofocus: false,
                              style: FontStyles.textField(textColor: PColors.white),
                              focusNode: searchFocusNode,
                              decoration: InputDecoration(
                                hintText: FlutterI18n.translate(context, "Cart.enterCouponCode"),
                                fillColor: searchFocusNode.hasFocus ? PColors.cardLightBackground : PColors.cardDark,
                                filled: true,
                                errorStyle: FontStyles.smallText(),
                                hintStyle: FontStyles.textField(),
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.horizontal(left: const Radius.circular(15)),
                                  borderSide: BorderSide(color: searchFocusNode.hasFocus ? PColors.cardLightBackground : PColors.cardDark),
                                ),
                                focusedBorder: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.horizontal(left: const Radius.circular(15)),
                                  borderSide: BorderSide(color: searchFocusNode.hasFocus ? PColors.cardLightBackground : PColors.cardDark),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10.0),
                              ),
                            ),
                          ),
                        ),
                        Consumer<UserProvider>(
                          builder: (context, model, child) => RaisedButton(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.horizontal(right: Radius.circular(15)),
                              ),
                              color: PColors.new_primary_button_b_y_ire_m,
                              onPressed: totalPrice > 0
                                  ? () async {
                                      if (_couponController.text.length > 0) {
                                        var response = await model.userCouponCode(_couponController.text, totalPrice);
                                        if (response != null) {
                                          if (totalPrice >= response.lowerLimit) {
                                            setState(() {});
                                          } else if (totalPrice < response.lowerLimit) {
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                                content: Text(
                                              FlutterI18n.translate(context, "Cart.min"),
                                            )));
                                          }
                                        } else {
                                          Scaffold.of(context).showSnackBar(SnackBar(
                                              content: Text(
                                            FlutterI18n.translate(context, "Cart.noCoupon"),
                                          )));
                                        }
                                      }
                                    }
                                  : null,
                              child: model.state == ServerState.Busy
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(PColors.white),
                                      ))
                                  : Text(
                                      FlutterI18n.translate(context, "Cart.apply"),
                                      style: FontStyles.text(textColor: PColors.white),
                                    )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    model.discountPercentage > 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                FlutterI18n.translate(context, "Cart.discount"),
                                style: FontStyles.text(textColor: PColors.blueGrey),
                              ),
                              Text(
                                "₺" + (totalPrice * model.discountPercentage / 100).toStringAsFixed(2),
                                style: FontStyles.text(textColor: PColors.blueGrey),
                              )
                            ],
                          )
                        : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          FlutterI18n.translate(context, "Cart.orderTotal"),
                          style: FontStyles.text(textColor: PColors.blueGrey),
                        ),
                        Text(
                          "₺" +
                              (model.discountPercentage > 0
                                  ? (totalPrice - ((totalPrice * model.discountPercentage / 100))).toStringAsFixed(2)
                                  : totalPrice.toStringAsFixed(2)),
                          style: FontStyles.text(textColor: PColors.blueGrey),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: PButton(
                            text: FlutterI18n.translate(context, "Cart.goPayment"),
                            onPressed: totalPrice > 0
                                ? () {
                                    Navigator.pushNamed(context, Routes.orderDetails);
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ));
          },
        ));
  }
}
