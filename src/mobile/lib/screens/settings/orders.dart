import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/admin/order_management_top_bar.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/settings_order_box.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/enums/order_state.dart';
import 'package:app/models/user_provider.dart';
import 'package:app/screens/settings/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class SettingsOrders extends StatefulWidget {
  @override
  _SettingsOrders createState() => _SettingsOrders();
}

class _SettingsOrders extends State<SettingsOrders> {
  int _state = -1;
  final f = new DateFormat('dd/MM/yyyy');

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  showSnackBar(String message) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        FlutterI18n.translate(context, message),
      ),
    ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "SettingsOrders.header"),
            style: FontStyles.header(),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 0, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 32,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  OrderManagementTopBar(
                    isActive: _state == -1,
                    header: FlutterI18n.translate(context, "SettingsOrders.waitingApproval"),
                    onPressed: () {
                      setState(() {
                        _state = -1;
                      });
                    },
                  ),
                  OrderManagementTopBar(
                    isActive: _state == 4,
                    header: FlutterI18n.translate(context, "SettingsOrders.beDelivered"),
                    onPressed: () {
                      setState(() {
                        _state = 4;
                      });
                    },
                  ),
                  OrderManagementTopBar(
                    isActive: _state == 1,
                    header: FlutterI18n.translate(context, "SettingsOrders.delivered"),
                    onPressed: () {
                      setState(() {
                        _state = 1;
                      });
                    },
                  ),
                  OrderManagementTopBar(
                    isActive: _state == 3,
                    header: FlutterI18n.translate(context, "SettingsOrders.cancelled"),
                    onPressed: () {
                      setState(() {
                        _state = 3;
                      });
                    },
                  ),
                  OrderManagementTopBar(
                    isActive: _state == 2,
                    header: FlutterI18n.translate(context, "SettingsOrders.notApproved"),
                    onPressed: () {
                      setState(() {
                        _state = 2;
                      });
                    },
                  ),
                  OrderManagementTopBar(
                    isActive: _state == 0,
                    header: FlutterI18n.translate(context, "SettingsOrders.waitingRefunds"),
                    onPressed: () {
                      setState(() {
                        _state = 0;
                      });
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: 28),
            Expanded(
              child: Consumer<UserProvider>(
                builder: (BuildContext context, UserProvider model, Widget child) => FutureBuilder(
                  future: model.getOrders(_state.toString()),
                  builder: (BuildContext context, AsyncSnapshot<List<GetOrdersOutputDTO>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return ListView.builder(
                          padding: EdgeInsets.only(right: 24),
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) => SettingsOrderBox(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SettingsOrderDetails(
                                        orderNo: snapshot.data[index].orderId,
                                        showSnackBar: showSnackBar,
                                      ),
                                    ));
                              },
                              orderNo: snapshot.data[index].orderId,
                              date: f.format(snapshot.data[index].date),
                              quantity: snapshot.data[index].quantity,
                              total: snapshot.data[index].amountPaid,
                              situation: OrderStateHelper.getEnum(snapshot.data[index].state).toString()),
                        );
                      } else {
                        return Center(
                          child: Text(
                            FlutterI18n.translate(context, "SettingsOrders.noOrder"),
                            textAlign: TextAlign.center,
                            style: FontStyles.text(),
                          ),
                        );
                      }
                    } else {
                      return Loading();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
