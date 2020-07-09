import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/admin/home_card.dart';
import 'package:app/design_system/atoms/admin/listing_card.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/or.dart';
import 'package:app/design_system/atoms/search_bar.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/admin_provider.dart';
import 'package:app/screens/Admin/coupon_add.dart';
import 'package:app/screens/Admin/detail_of_coupon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class CouponManagement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CouponManagement();
}

class _CouponManagement extends State<CouponManagement> {
  FocusNode searchFocusNode = new FocusNode();
  TextEditingController _searchController = TextEditingController();
  final f = new DateFormat('dd/MM/yyyy');
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  showSnackBar(String message) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        FlutterI18n.translate(context, message),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PColors.darkBackground,
        key: _scaffoldKey,
        appBar: PAppBar(
          isCenter: true,
          children: <Widget>[
            Text(
              FlutterI18n.translate(context, "CouponManagement.header"),
              style: FontStyles.header(),
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Consumer<AdminProvider>(
              builder: (BuildContext context, AdminProvider model, Widget child) => FutureBuilder(
                future: model.getCouponCodes(_searchController.text),
                builder: (BuildContext context, AsyncSnapshot<List<ListingCouponsOutputDTO>> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        AdminHomeCard(
                          boxColor: PColors.orange,
                          boxIcon: PIcons.couponcode,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CouponAdd(
                                    showSnackBar: showSnackBar,
                                  ),
                                ));
                          },
                          text: FlutterI18n.translate(context, "ProductManagement.addCouponCode"),
                        ),
                        SizedBox(height: 24),
                        Or(),
                        SizedBox(height: 24),
                        Text(FlutterI18n.translate(context, "CouponManagement.search"), style: FontStyles.header()),
                        SizedBox(height: 12),
                        SearchBar(
                          placeholderText: FlutterI18n.translate(context, "CouponManagement.placeholderSearch"),
                          requestFocus: _requestFocus,
                          focusNode: searchFocusNode,
                          onChange: (_) {
                            setState(() {});
                          },
                          controller: _searchController,
                        ),
                        SizedBox(height: 12),
                        Expanded(
                          child: snapshot.data.length > 0
                              ? ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return AdminListingCard(
                                      boxIcon: PIcons.usedcoupon,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailOfCoupon(
                                                showSnackBar: showSnackBar,
                                                couponID: snapshot.data[index].couponId,
                                              ),
                                            ));
                                      },
                                      children: <Widget>[
                                        Text(snapshot.data[index].header, style: FontStyles.textFieldHighlighted(textColor: PColors.white)),
                                        SizedBox(height: 4),
                                        Text(snapshot.data[index].code,
                                            style: FontStyles.bigTextField(textColor: PColors.new_primary_button_b_y_ire_m)),
                                        SizedBox(height: 4),
                                        Text(
                                          FlutterI18n.translate(context, "CouponManagement.countLeft") +
                                              snapshot.data[index].remainingQuantity.toStringAsFixed(0),
                                          style: FontStyles.smallTextRegular(textColor: PColors.blueGrey),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          FlutterI18n.translate(context, "CouponManagement.totalCount") +
                                              snapshot.data[index].startQuantity.toStringAsFixed(0),
                                          style: FontStyles.smallTextRegular(textColor: PColors.blueGrey),
                                        )
                                      ],
                                      bottomRightWidget: Text(f.format(snapshot.data[index].expireTime), style: FontStyles.smallText()),
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                    FlutterI18n.translate(context, "CouponManagement.noCode"),
                                    textAlign: TextAlign.center,
                                    style: FontStyles.text(),
                                  ),
                                ),
                        )
                      ],
                    );
                  }
                  return Loading();
                },
              ),
            )));
  }
}
