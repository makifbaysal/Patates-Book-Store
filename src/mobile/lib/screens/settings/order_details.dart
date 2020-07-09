import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/admin/listing_card.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/pbutton.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/molecules/dialog.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/dialog_action_state.dart';
import 'package:app/enums/order_state.dart';
import 'package:app/models/user_provider.dart';
import 'package:app/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class SettingsOrderDetails extends StatelessWidget {
  final String orderNo;
  final Function showSnackBar;

  const SettingsOrderDetails({Key key, this.orderNo, this.showSnackBar}) : super(key: key);

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Consumer<UserProvider>(
          builder: (BuildContext context, UserProvider model, Widget child) => FutureBuilder(
            future: model.getOrderDetail(orderNo),
            builder: (BuildContext context, AsyncSnapshot<OrderDetailsOutputDTO> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
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
                                    orderNo,
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
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.products.length,
                              itemBuilder: (context, index) {
                                return AdminListingCard(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetails(
                                            productId: snapshot.data.products[index].productId,
                                          ),
                                        ));
                                  },
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
                                    Text(
                                        FlutterI18n.translate(context, "SettingsOrderDetails.numberOfProducts") +
                                            snapshot.data.products[index].quantity.toString(),
                                        style: FontStyles.smallText(textColor: PColors.white))
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    ([-1, 1].contains(snapshot.data.state))
                        ? PButton(
                            text: snapshot.data.state == 1
                                ? FlutterI18n.translate(context, "SettingsOrderDetails.wantRefund")
                                : FlutterI18n.translate(context, "SettingsOrderDetails.cancel"),
                            color: PColors.red,
                            onPressed: () async {
                              switch (snapshot.data.state) {
                                case 1:
                                  final action = await OPDialog.yesAbortDialog(
                                      context,
                                      FlutterI18n.translate(context, "SettingsOrderDetails.ensureRefund"),
                                      FlutterI18n.translate(context, "yes"),
                                      FlutterI18n.translate(context, "no"),
                                      color: PColors.red);
                                  if (action == DialogActionState.Yes) {
                                    await model.refundOrder(orderNo);
                                    Navigator.pop(context);
                                    showSnackBar(FlutterI18n.translate(context, "SettingsOrderDetails.successRefundRequest"));
                                  }
                                  return;
                                default:
                                  final action = await OPDialog.yesAbortDialog(
                                      context,
                                      FlutterI18n.translate(context, "SettingsOrderDetails.ensureCancel"),
                                      FlutterI18n.translate(context, "yes"),
                                      FlutterI18n.translate(context, "no"),
                                      color: PColors.red);
                                  if (action == DialogActionState.Yes) {
                                    await model.cancelOrder(orderNo);
                                    Navigator.pop(context);
                                    showSnackBar(FlutterI18n.translate(context, "SettingsOrderDetails.successCancelRequest"));
                                  }
                                  return;
                              }
                            },
                          )
                        : Container(),
                    (snapshot.data.state == 4)
                        ? SizedBox(
                            height: 12,
                          )
                        : Container(),
                    (snapshot.data.state == 4)
                        ? PButton(
                            text: FlutterI18n.translate(context, "OrderAddress.confirm"),
                            onPressed: () async {
                              final action = await OPDialog.yesAbortDialog(
                                context,
                                FlutterI18n.translate(context, "SettingsOrderDetails.ensureGivingOrder"),
                                FlutterI18n.translate(context, "yes"),
                                FlutterI18n.translate(context, "no"),
                              );
                              if (action == DialogActionState.Yes) {
                                await model.acceptOrder(orderNo);
                                Navigator.pop(context);
                                showSnackBar(FlutterI18n.translate(context, "SettingsOrderDetails.successGivingOrder"));
                              }
                            },
                          )
                        : Container()
                  ],
                );
              } else {
                return Loading();
              }
            },
          ),
        ),
      ),
    );
  }
}
