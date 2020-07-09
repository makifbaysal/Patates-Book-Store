import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/admin/little_report_card.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/p_card.dart';
import 'package:app/design_system/atoms/report_card.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class SaleReports extends StatefulWidget {
  @override
  _SaleReports createState() => _SaleReports();
}

class _SaleReports extends State<SaleReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "SaleReports.header"),
            style: FontStyles.header(),
          )
        ],
      ),
      backgroundColor: PColors.darkBackground,
      body: Consumer<AdminProvider>(
        builder: (BuildContext context, AdminProvider model, Widget child) {
          return FutureBuilder(
            future: model.getAdminReports(),
            builder: (BuildContext context, AsyncSnapshot<AdminReportOutputDTO> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PCard(
                      child: Column(
                        children: <Widget>[
                          ReportCard(
                            header: FlutterI18n.translate(context, "SaleReports.totalAccounts"),
                            count: snapshot.data.totalUser.toString(),
                            color: PColors.blue3,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  child: ReportCard(
                                    header: FlutterI18n.translate(context, "SaleReports.countOfOrders"),
                                    count: snapshot.data.totalOrder.toString(),
                                    color: PColors.red,
                                  ),
                                  flex: 10),
                              Expanded(child: Container(), flex: 1),
                              Expanded(
                                  child: ReportCard(
                                    header: FlutterI18n.translate(context, "SaleReports.totalIncome"),
                                    count: "₺" + snapshot.data.totalRevenue.toStringAsFixed(2),
                                    color: PColors.green2,
                                  ),
                                  flex: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          LittleReportCard(
                            header: FlutterI18n.translate(context, "SaleReports.mostOrderedCategory"),
                            count: snapshot.data.mostOrderCategoryCount.toString(),
                            icon: PIcons.favouritebook,
                            miniHeader: snapshot.data.mostOrderCategory.toString(),
                          ),
                          LittleReportCard(
                            header: FlutterI18n.translate(context, "SaleReports.mostPreferedCargoCompany"),
                            count: snapshot.data.mostOrderShippingCompanyCount.toString(),
                            icon: PIcons.cargo,
                            miniHeader: snapshot.data.mostOrderShippingCompany.toString(),
                          ),
                          LittleReportCard(
                            header: FlutterI18n.translate(context, "SaleReports.totalUsedCouponCodes"),
                            count: snapshot.data.usedCoupon.toString(),
                            icon: PIcons.usedcoupon,
                          ),
                          LittleReportCard(
                            header: FlutterI18n.translate(context, "SaleReports.mostOrderedUser"),
                            count: snapshot.data.mostOrderUserCount.toString(),
                            icon: PIcons.account,
                            miniHeader: snapshot.data.mostOrderUser.toString(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Loading();
            },
          );
        },
      ),
    );
  }
}

// iremiko
