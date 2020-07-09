import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/admin/listing_card.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/order_state.dart';
import 'package:app/models/user_provider.dart';
import 'package:app/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class OrderSummary extends StatelessWidget {
  final String orderId;

  const OrderSummary({Key key, this.orderId}) : super(key: key);

//TODO josn a eklenince burayı da düzelt
  String getEnumText(context, OrderState orderEnum) {
    return FlutterI18n.translate(context, OrderState.WaitingForApproval.toString());
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider model = Provider.of<UserProvider>(context);
    final f = new DateFormat('dd.MM.yyyy');
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(context, Routes.home, ModalRoute.withName(Routes.home));
        return null;
      },
      child: Scaffold(
          appBar: PAppBar(
            isCenter: true,
            children: <Widget>[
              Text(
                FlutterI18n.translate(context, "OrderSummary.summary"),
                style: FontStyles.header(),
              )
            ],
          ),
          backgroundColor: PColors.darkBackground,
          body: FutureBuilder(
            future: model.getOrderDetail(orderId),
            builder: (BuildContext context, AsyncSnapshot<OrderDetailsOutputDTO> snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                  child: Column(
                    children: <Widget>[
                      Table(
                        columnWidths: {0: FractionColumnWidth(.4), 1: FractionColumnWidth(.6)},
                        border: TableBorder.all(style: BorderStyle.none, width: 10),
                        children: [
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    FlutterI18n.translate(context, "DetailOfOrder.no"),
                                    style: FontStyles.text(textColor: PColors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    orderId,
                                    style: FontStyles.text(textColor: PColors.white),
                                  ),
                                )
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    FlutterI18n.translate(context, "DetailOfOrder.situation"),
                                    style: FontStyles.text(textColor: PColors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    getEnumText(context, OrderStateHelper.getEnum(snapshot.data.state)),
                                    style: FontStyles.text(textColor: PColors.new_primary_button_b_y_ire_m),
                                  ),
                                )
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    FlutterI18n.translate(context, "DetailOfOrder.cost"),
                                    style: FontStyles.text(textColor: PColors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    "₺" + snapshot.data.amountPaid.toStringAsFixed(2),
                                    style: FontStyles.text(textColor: PColors.white),
                                  ),
                                )
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    FlutterI18n.translate(context, "DetailOfOrder.payment"),
                                    style: FontStyles.text(textColor: PColors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    FlutterI18n.translate(context, "OrderSummary.creditCard"),
                                    style: FontStyles.text(textColor: PColors.white),
                                  ),
                                )
                              ]),
                            ] +
                            (snapshot.data.coupon != null
                                ? [
                                    TableRow(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 12.0),
                                        child: Text(
                                          FlutterI18n.translate(context, "OrderSummary.couponCode"),
                                          style: FontStyles.text(textColor: PColors.white),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(bottom: 12.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                snapshot.data.coupon,
                                                style: FontStyles.textField(textColor: PColors.white),
                                              ),
                                              Text(
                                                "(%" +
                                                    snapshot.data.percentageDiscount.toString() +
                                                    FlutterI18n.translate(context, "OrderSummary.discount"),
                                                style: FontStyles.smallTextRegular(textColor: PColors.white),
                                              ),
                                            ],
                                          ))
                                    ]),
                                  ]
                                : []) +
                            [
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    FlutterI18n.translate(context, "DetailOfOrder.address"),
                                    style: FontStyles.text(textColor: PColors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    snapshot.data.address,
                                    style: FontStyles.text(textColor: PColors.white),
                                  ),
                                )
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    FlutterI18n.translate(context, "DetailOfOrder.shippingCompany"),
                                    style: FontStyles.text(textColor: PColors.white),
                                  ),
                                ),
                                Text(
                                  snapshot.data.shippingCompany,
                                  style: FontStyles.text(textColor: PColors.white),
                                )
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    FlutterI18n.translate(context, "OrderSummary.orderDate"),
                                    style: FontStyles.text(textColor: PColors.white),
                                  ),
                                ),
//TODO : diğer tüm datelerle eklencek
                                Text(
                                  f.format(snapshot.data.date),
                                  style: FontStyles.textField(textColor: PColors.white),
                                )
                              ]),
                            ],
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.products.length,
                          itemBuilder: (context, index) {
                            return AdminListingCard(
                              imgUrl: snapshot.data.products[index].imageUrl,
                              bottomRightWidget: Text(
                                "₺" + (snapshot.data.products[index].unitPrice * snapshot.data.products[index].quantity).toStringAsFixed(2),
                                style: FontStyles.bigTextField(textColor: PColors.new_primary_button_b_y_ire_m),
                              ),
                              children: <Widget>[
                                Text(snapshot.data.products[index].name, style: FontStyles.bigTextField(textColor: PColors.white)),
                                SizedBox(height: 4),
                                Text(snapshot.data.products[index].author, style: FontStyles.textField(textColor: PColors.blueGrey)),
                                SizedBox(height: 12),
                                Text(FlutterI18n.translate(context, "OrderSummary.productNum") + snapshot.data.products[index].quantity.toString(),
                                    style: FontStyles.smallText(textColor: PColors.white))
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              }
              return Loading();
            },
          )),
    );
  }
}
