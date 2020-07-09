import 'package:app/design_system/atoms/admin/add_photo_card.dart';
import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/admin/uncustomizable_text_field.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../router.dart';

class DetailOfShippingCompany extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[Text(FlutterI18n.translate(context, "ShippingCompanyShow.header"), style: FontStyles.header())],
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.admin.shippingCompanyManagement);
            },
            child: Icon(PIcons.edit, color: PColors.white, size: 25),
          ),
          SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, Routes.admin.shippingCompanyManagement);
            },
            child: Icon(PIcons.delete, color: PColors.red, size: 25),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Row(
            children: <Widget>[
              AddPhotoCard(),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(FlutterI18n.translate(context, "ShippingCompanyShow.companyNameHeader"),
                        style: FontStyles.header(textColor: PColors.blueGrey)),
                    SizedBox(height: 8),
                    Container(
                      height: 61,
                      child: UncustomizableTextField(
                        placeholderText: "UPS Kargo",
                      ),
                    ),
                    SizedBox(height: 28),
                    Text(FlutterI18n.translate(context, "ShippingCompanyShow.phoneHeader"), style: FontStyles.header(textColor: PColors.blueGrey)),
                    SizedBox(height: 8),
                    Container(
                      height: 61,
                      child: UncustomizableTextField(
                        placeholderText: "0850 255 00 66",
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(FlutterI18n.translate(context, "ShippingCompanyShow.websiteHeader"), style: FontStyles.header(textColor: PColors.blueGrey)),
                    SizedBox(height: 8),
                    Container(
                      height: 60,
                      child: UncustomizableTextField(
                        placeholderText: "www.ups.com.tr",
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(FlutterI18n.translate(context, "ShippingCompanyShow.contractEndDateHeader"),
                        style: FontStyles.header(textColor: PColors.blueGrey)),
                    SizedBox(height: 8),
                    Container(
                      height: 60,
                      child: UncustomizableTextField(
                        placeholderText: "29/06/2024",
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
