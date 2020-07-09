import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class SettingsCouponCodes extends StatelessWidget {
  final f = new DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "SettingsCouponCodes.header"),
            style: FontStyles.header(textColor: PColors.white),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Consumer<UserProvider>(
          builder: (BuildContext context, model, Widget child) => FutureBuilder(
            future: model.getAvailableCoupons(),
            builder: (BuildContext context, AsyncSnapshot<List<ListingCouponsOutputDTO>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.only(bottom: 12),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: PColors.cardDark,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  snapshot.data[index].code,
                                  style: FontStyles.bigTextField(textColor: PColors.orange),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  snapshot.data[index].header,
                                  style: FontStyles.bigTextField(textColor: PColors.white),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  snapshot.data[index].description,
                                  style: FontStyles.text(textColor: PColors.blueGrey),
                                ),
                                SizedBox(height: 8),
                                Table(
                                  columnWidths: {0: FractionColumnWidth(.5), 1: FractionColumnWidth(.5)},
                                  children: [
                                    TableRow(children: [
                                      Text(FlutterI18n.translate(context, "SettingsCouponCodes.discountPercentage"),
                                          style: FontStyles.smallText(textColor: PColors.white)),
                                      Text("%" + snapshot.data[index].percentageDiscount.toInt().toString(),
                                          style: FontStyles.smallText(textColor: PColors.white)),
                                    ]),
                                    TableRow(children: [
                                      Text(FlutterI18n.translate(context, "SettingsCouponCodes.expireTime"),
                                          style: FontStyles.smallText(textColor: PColors.white)),
                                      Text(f.format(snapshot.data[index].expireTime), style: FontStyles.smallText(textColor: PColors.white)),
                                    ])
                                  ],
                                ),
                              ],
                            ),
                          ));
                }
                return Center(
                  child: Text(
                    FlutterI18n.translate(context, "SettingsCouponCodes.noCode"),
                    style: FontStyles.text(),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return Loading();
            },
          ),
        ),
      ),
    );
  }
}
