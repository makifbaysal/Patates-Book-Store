import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/screens/Admin/detail_of_coupon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class CouponPage extends StatefulWidget {
  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  bool isEditing = false;

  Widget getPageContent() {
    if (isEditing) {
      return null;
    } else {
      return DetailOfCoupon();
    }
  }

  String getHeader(BuildContext context) {
    if (isEditing) {
      return FlutterI18n.translate(context, "AddCoupon.headerEdit");
    } else {
      return FlutterI18n.translate(context, "DetailOfCoupon.header");
    }
  }

  List<Widget> getActions(BuildContext context) {
    if (isEditing) {
      return <Widget>[
        GestureDetector(
            onTap: () {
              setState(() {
                isEditing = false;
              });
            },
            child: Icon(PIcons.save)),
      ];
    } else {
      return <Widget>[
        GestureDetector(
            onTap: () {
              setState(() {
                isEditing = true;
              });
            },
            child: Icon(PIcons.edit)),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (isEditing) {
          setState(() {
            isEditing = false;
          });
        } else {
          Navigator.pop(context);
        }

        return;
      },
      child: Scaffold(
        backgroundColor: PColors.darkBackground,
        body: getPageContent(),
        appBar: PAppBar(isCenter: true, children: <Widget>[Text(getHeader(context), style: FontStyles.header())], actions: getActions(context)),
      ),
    );
  }
}
