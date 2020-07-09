import 'package:app/design_system/atoms/account_pp.dart';
import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/admin/home_card.dart';
import 'package:app/design_system/atoms/p_card.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/product_provider.dart';
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

import '../../router.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "AdminHome.header"),
            style: FontStyles.header(),
          )
        ],
        actions: <Widget>[
          Consumer2<UserProvider, ProductProvider>(
            builder: (BuildContext context, model, productModel, Widget child) => IconButton(
                onPressed: () async {
                  Navigator.pushNamedAndRemoveUntil(context, Routes.login, ModalRoute.withName(Routes.login)).whenComplete(() async {
                    await model.logout();
                    await productModel.clearCompareProducts();
                  });
                },
                icon: Icon(PIcons.logoutadmin)),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          PCard(
            child: Row(
              children: <Widget>[
                AccountPP(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Consumer<UserProvider>(
                                builder: (context, model, child) =>
                                    Text(model.nameSurname, overflow: TextOverflow.ellipsis, style: FontStyles.header())),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.admin.account);
                              },
                              child: Icon(
                                PIcons.edit,
                                size: 25,
                                color: PColors.blueGrey,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          FlutterI18n.translate(context, "AdminHome.admin"),
                          style: FontStyles.text(),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                AdminHomeCard(
                  boxColor: PColors.purple,
                  boxIcon: PIcons.salereports,
                  text: FlutterI18n.translate(context, "AdminHome.saleReports"),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.admin.saleReports);
                  },
                ),
                SizedBox(height: 20),
                AdminHomeCard(
                    boxColor: PColors.green1,
                    boxIcon: PIcons.productmanagement,
                    text: FlutterI18n.translate(context, "AdminHome.productManagement"),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.admin.productManagement);
                    }),
                SizedBox(height: 20),
                AdminHomeCard(
                    boxColor: PColors.orange,
                    boxIcon: PIcons.usermanagement,
                    text: FlutterI18n.translate(context, "AdminHome.accountManagement"),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.admin.userManagement);
                    }),
                SizedBox(height: 20),
                AdminHomeCard(
                    boxColor: PColors.blue3,
                    boxIcon: PIcons.box,
                    text: FlutterI18n.translate(context, "AdminHome.orderManagement"),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.admin.orderManagement);
                    }),
                SizedBox(height: 20),
                AdminHomeCard(
                  boxColor: PColors.red,
                  boxIcon: PIcons.cargo,
                  text: FlutterI18n.translate(context, "AdminHome.shippingManagement"),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.admin.shippingCompanyManagement);
                  },
                ),
                SizedBox(height: 20),
                AdminHomeCard(
                  boxColor: PColors.new_primary_button_b_y_ire_m,
                  boxIcon: PIcons.income,
                  text: FlutterI18n.translate(context, "AdminHome.couponManagement"),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.admin.couponManagement);
                  },
                ),
                SizedBox(height: 20),
                AdminHomeCard(
                  boxColor: Colors.pinkAccent,
                  boxIcon: Icons.inbox,
                  text: FlutterI18n.translate(context, "AdminHome.messageManagement"),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.admin.messageManagement);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
