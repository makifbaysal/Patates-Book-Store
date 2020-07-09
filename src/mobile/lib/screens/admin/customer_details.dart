import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/settings_order_box.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:openapi/api.dart';

class AdminCustomerDetails extends StatelessWidget {
  final List<GetOrdersOutputDTO> orders;
  final double amount;

  const AdminCustomerDetails({Key key, this.orders, this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "AdminCustomerDetails.header"),
            style: FontStyles.header(textColor: PColors.white),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: orders.length > 0
            ? Column(
                children: <Widget>[
                  Text(
                    FlutterI18n.translate(context, "AdminCustomerDetails.totalSpent") + amount.toString(),
                    style: FontStyles.text(textColor: PColors.white),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: orders.length,
                      itemBuilder: (BuildContext context, int index) => SettingsOrderBox(
                          orderNo: orders[index].orderId,
                          date: DateFormat('dd/MM/yyyy').format(orders[index].date),
                          total: orders[index].amountPaid,
                          quantity: orders[index].quantity,
                          situation: OrderStateHelper.getEnum(orders[index].state).toString()),
                    ),
                  ),
                ],
              )
            : Center(
                child: Text(
                  FlutterI18n.translate(context, "AdminCustomerDetails.noOrder"),
                  textAlign: TextAlign.center,
                  style: FontStyles.text(),
                ),
              ),
      ),
    );
  }
}
