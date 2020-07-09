import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/admin/listing_card.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/molecules/dialog.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/dialog_action_state.dart';
import 'package:app/enums/order_state.dart';
import 'package:app/models/admin_provider.dart';
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class DetailOfOrder extends StatelessWidget {
  final String orderId;
  final Function showSnackBar;

  const DetailOfOrder({Key key, this.orderId, this.showSnackBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "DetailOfOrder.header"),
            style: FontStyles.header(),
          )
        ],
      ),
      backgroundColor: PColors.darkBackground,
      body: Consumer<UserProvider>(
        builder: (BuildContext context, UserProvider model, Widget child) => FutureBuilder(
          future: model.getOrderDetail(orderId),
          builder: (BuildContext context, AsyncSnapshot<OrderDetailsOutputDTO> snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              snapshot.data.orderNo,
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
                              FlutterI18n.translate(context, OrderStateHelper.getEnum(snapshot.data.state).toString()),
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
                        snapshot.data.coupon != null
                            ? TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    FlutterI18n.translate(context, "DetailOfOrder.coupon"),
                                    style: FontStyles.text(textColor: PColors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    snapshot.data.coupon,
                                    style: FontStyles.text(textColor: PColors.white),
                                  ),
                                )
                              ])
                            : TableRow(children: [
                                SizedBox(),
                                SizedBox(),
                              ]),
                        snapshot.data.coupon != null
                            ? TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    FlutterI18n.translate(context, "DetailOfOrder.discount"),
                                    style: FontStyles.text(textColor: PColors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    "%" + snapshot.data.percentageDiscount.toStringAsFixed(0),
                                    style: FontStyles.text(textColor: PColors.white),
                                  ),
                                )
                              ])
                            : TableRow(children: [
                                SizedBox(),
                                SizedBox(),
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
                              "Kredi Kartı",
                              style: FontStyles.text(textColor: PColors.white),
                            ),
                          )
                        ]),
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
                          Text(
                            FlutterI18n.translate(context, "DetailOfOrder.shippingCompany"),
                            style: FontStyles.text(textColor: PColors.white),
                          ),
                          Text(
                            snapshot.data.shippingCompany,
                            style: FontStyles.text(textColor: PColors.white),
                          )
                        ]),
                      ],
                    ),
                    SizedBox(height: 20),
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
                            Text(FlutterI18n.translate(context, "DetailOfOrder.countOfProduct2") + snapshot.data.products[index].quantity.toString(),
                                style: FontStyles.smallText(textColor: PColors.white))
                          ],
                        );
                      },
                    )),
                    [-1, 0].contains(snapshot.data.state)
                        ? Consumer<AdminProvider>(
                            builder: (BuildContext context, AdminProvider adminProvider, Widget child) => Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: PButton(
                                text: FlutterI18n.translate(
                                    context, snapshot.data.state == -1 ? "DetailOfOrder.confirm" : "DetailOfOrder.acceptRefund"),
                                onPressed: () async {
                                  if (snapshot.data.state == -1) {
                                    final action = await OPDialog.yesAbortDialog(
                                      context,
                                      FlutterI18n.translate(context, "DetailOfOrder.ensureConfirmOrder"),
                                      FlutterI18n.translate(context, "yes"),
                                      FlutterI18n.translate(context, "no"),
                                    );
                                    if (action == DialogActionState.Yes) {
                                      var response = await adminProvider.confirmOrder(orderId);
                                      if (response == "Error") {
                                        Scaffold.of(context).showSnackBar(SnackBar(
                                            content: Text(
                                          FlutterI18n.translate(context, "DetailOfOrder.stockError"),
                                        )));
                                      } else {
                                        Navigator.pop(context);
                                        showSnackBar(FlutterI18n.translate(context, "Sipariş onaylandı"));
                                      }
                                    }
                                  } else {
                                    final action = await OPDialog.yesAbortDialog(
                                      context,
                                      FlutterI18n.translate(context, "DetailOfOrder.ensureRefundOrder"),
                                      FlutterI18n.translate(context, "yes"),
                                      FlutterI18n.translate(context, "no"),
                                    );
                                    if (action == DialogActionState.Yes) {
                                      await adminProvider.refundOrder(orderId, true);
                                      Navigator.pop(context);
                                      showSnackBar(FlutterI18n.translate(context, "DetailOfOrder.successRefund"));
                                    }
                                  }
                                },
                              ),
                            ),
                          )
                        : Container(),
                    [-1, 0].contains(snapshot.data.state)
                        ? SizedBox(
                            height: 12,
                          )
                        : Container(),
                    [-1, 0].contains(snapshot.data.state)
                        ? Consumer<AdminProvider>(
                            builder: (BuildContext context, AdminProvider adminProvider, Widget child) => Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: PButton(
                                color: PColors.red,
                                text: FlutterI18n.translate(context, "DetailOfOrder.reject"),
                                onPressed: () async {
                                  if (snapshot.data.state == -1) {
                                    final action = await OPDialog.yesAbortDialog(
                                        context,
                                        FlutterI18n.translate(context, "DetailOfOrder.ensureRejectOrder"),
                                        FlutterI18n.translate(context, "yes"),
                                        FlutterI18n.translate(context, "no"),
                                        color: PColors.red);
                                    if (action == DialogActionState.Yes) {
                                      await adminProvider.rejectOrder(orderId);
                                      Navigator.pop(context);
                                      showSnackBar(FlutterI18n.translate(context, "DetailOfOrder.successReject"));
                                    }
                                  } else {
                                    final action = await OPDialog.yesAbortDialog(
                                        context,
                                        FlutterI18n.translate(context, "DetailOfOrder.ensureRejectRefund"),
                                        FlutterI18n.translate(context, "yes"),
                                        FlutterI18n.translate(context, "no"),
                                        color: PColors.red);
                                    if (action == DialogActionState.Yes) {
                                      await adminProvider.refundOrder(orderId, false);
                                      Navigator.pop(context);
                                      showSnackBar(FlutterI18n.translate(context, "DetailOfOrder.successRejectRefund"));
                                    }
                                  }
                                },
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              );
            } else {
              return Loading();
            }
          },
        ),
      ),
    );
  }
}
