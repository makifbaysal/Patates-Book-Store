import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/molecules/dialog.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/dialog_action_state.dart';
import 'package:app/models/user_provider.dart';
import 'package:app/screens/order_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class ConfirmOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider model = Provider.of<UserProvider>(context);
    final f = new DateFormat('dd.MM.yyyy');

    return Scaffold(
        appBar: PAppBar(
          isCenter: true,
          children: <Widget>[
            Text(
              FlutterI18n.translate(context, "ConfirmOrder.header"),
              style: FontStyles.header(),
            )
          ],
        ),
        backgroundColor: PColors.darkBackground,
        body: FutureBuilder(
            future: model.getShoppingCard(),
            builder: (BuildContext context, AsyncSnapshot<List<ShoppingCartProductListingOutputDTO>> snapshot) {
              if (snapshot.hasData) {
                double totalPrice = 0;
                snapshot.data.forEach((product) {
                  totalPrice += product.price * product.quantity;
                });
                return Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Table(
                          columnWidths: {0: FractionColumnWidth(.4), 1: FractionColumnWidth(.6)},
                          border: TableBorder.all(style: BorderStyle.none, width: 10),
                          children: [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12.0),
                                      child: Text(
                                        FlutterI18n.translate(context, "ConfirmOrder.cartInfo"),
                                        style: FontStyles.text(textColor: PColors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            FlutterI18n.translate(context, "ConfirmOrder.cart"),
                                            style: FontStyles.textField(textColor: PColors.white),
                                          ),
                                          Text(
                                            "(" + model.selectedCart.cartNumber + " no’lu kart)",
                                            style: FontStyles.smallTextRegular(textColor: PColors.white),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12.0),
                                      child: Text(
                                        FlutterI18n.translate(context, "ConfirmOrder.shippingAddress"),
                                        style: FontStyles.text(textColor: PColors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 12.0),
                                      child: Text(
                                        model.selectedAddress.address,
                                        style: FontStyles.textField(textColor: PColors.white),
                                      ),
                                    )
                                  ],
                                ),
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: Text(
                                      FlutterI18n.translate(context, "ConfirmOrder.shippingCompany"),
                                      style: FontStyles.text(textColor: PColors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: Text(
                                      model.selectedShippingCompany.name,
                                      style: FontStyles.textField(textColor: PColors.white),
                                    ),
                                  )
                                ]),
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: Text(
                                      FlutterI18n.translate(context, "ConfirmOrder.deliveryDate"),
                                      style: FontStyles.text(textColor: PColors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          f.format(DateTime.now().add(Duration(days: 5))),
                                          style: FontStyles.textField(textColor: PColors.white),
                                        ),
                                        Text(
                                          FlutterI18n.translate(context, "ConfirmOrder.expectedDeliveryDate"),
                                          style: FontStyles.smallTextRegular(textColor: PColors.white),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                              ] +
                              (model.couponCode != null
                                  ? [
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 12.0),
                                          child: Text(
                                            FlutterI18n.translate(context, "ConfirmOrder.couponCode"),
                                            style: FontStyles.text(textColor: PColors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 12.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                model.couponCode,
                                                style: FontStyles.textField(textColor: PColors.white),
                                              ),
                                              Text(
                                                "(%" +
                                                    model.discountPercentage.toStringAsFixed(2) +
                                                    " " +
                                                    FlutterI18n.translate(context, "ConfirmOrder.discount") +
                                                    ")",
                                                style: FontStyles.smallTextRegular(textColor: PColors.white),
                                              ),
                                            ],
                                          ),
                                        )
                                      ])
                                    ]
                                  : []),
                        ),
                        SizedBox(height: 24),
                        Text(
                          FlutterI18n.translate(context, "ConfirmOrder.orderSummary"),
                          style: FontStyles.header(textColor: PColors.blueGrey),
                        ),
                        SizedBox(height: 24),
                        Expanded(
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: PColors.cardLightBackground,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Table(
                                        columnWidths: {0: FractionColumnWidth(.6), 1: FractionColumnWidth(.2), 2: FractionColumnWidth(.2)},
                                        border: TableBorder.all(style: BorderStyle.none, width: 10),
                                        children: snapshot.data
                                            .map(
                                              (product) => TableRow(children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 12.0),
                                                  child: Text(
                                                    product.name,
                                                    style: FontStyles.textField(textColor: PColors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 12.0),
                                                  child: Text(
                                                    "x" + product.quantity.toString(),
                                                    style: FontStyles.textField(textColor: PColors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 12.0),
                                                  child: Text(
                                                    "₺" + product.price.toStringAsFixed(2),
                                                    style: FontStyles.textField(textColor: PColors.white),
                                                  ),
                                                ),
                                              ]),
                                            )
                                            .toList()),
                                    SizedBox(height: 8),
                                    Container(height: 1.0, color: PColors.blueGrey),
                                    SizedBox(height: 12),
                                    Table(
                                      columnWidths: {
                                        0: FractionColumnWidth(.8),
                                        1: FractionColumnWidth(.2),
                                      },
                                      border: TableBorder.all(style: BorderStyle.none, width: 10),
                                      children: [
                                            TableRow(children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 12.0),
                                                child: Text(
                                                  FlutterI18n.translate(context, "ConfirmOrder.shippingCost"),
                                                  style: FontStyles.textField(textColor: PColors.white),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 12.0),
                                                child: Text(
                                                  "₺" + model.selectedShippingCompany.price.toStringAsFixed(2),
                                                  style: FontStyles.textField(textColor: PColors.white),
                                                ),
                                              ),
                                            ]),
                                          ] +
                                          (model.couponCode != null
                                              ? [
                                                  TableRow(children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 12.0),
                                                      child: Text(
                                                        FlutterI18n.translate(context, "ConfirmOrder.discount"),
                                                        style: FontStyles.textField(textColor: PColors.white),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 12.0),
                                                      child: Text(
                                                        "₺" + (totalPrice * model.discountPercentage / 100).toStringAsFixed(2),
                                                        style: FontStyles.textField(textColor: PColors.white),
                                                      ),
                                                    ),
                                                  ]),
                                                ]
                                              : []),
                                    ),
                                    Container(height: 1.0, color: PColors.blueGrey),
                                    SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          FlutterI18n.translate(context, "ConfirmOrder.total"),
                                          style: FontStyles.bigText(textColor: PColors.white),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            "₺" +
                                                ((totalPrice - ((totalPrice * model.discountPercentage / 100))) + model.selectedShippingCompany.price)
                                                    .toStringAsFixed(2),
                                            style: FontStyles.bigText(textColor: PColors.white),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: PButton(
                                  text: FlutterI18n.translate(context, "ConfirmOrder.pay"),
                                  onPressed: () async {
                                    final action = await OPDialog.yesAbortDialog(
                                      context,
                                      FlutterI18n.translate(context, "ConfirmOrder.fromCard") +
                                          ((totalPrice - ((totalPrice * model.discountPercentage / 100))) + model.selectedShippingCompany.price)
                                              .toStringAsFixed(2) +
                                          FlutterI18n.translate(context, "ConfirmOrder.confirm"),
                                      FlutterI18n.translate(context, "yes"),
                                      FlutterI18n.translate(context, "no"),
                                    );
                                    if (action == DialogActionState.Yes) {
                                      var response = await model.createOrder(
                                          ((totalPrice - ((totalPrice * model.discountPercentage / 100))) + model.selectedShippingCompany.price));
                                      if (response == "Error") {
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                            content: Text(
                                          FlutterI18n.translate(context, "ConfirmOrder.fail"),
                                        )));
                                      } else if (response == "Insufficient Funds") {
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                            content: Text(
                                          FlutterI18n.translate(context, "ConfirmOrder.insufficientFunds"),
                                        )));
                                      } else {
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderSummary(orderId: response)));
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ));
              }
              return Loading();
            }));
  }
}
