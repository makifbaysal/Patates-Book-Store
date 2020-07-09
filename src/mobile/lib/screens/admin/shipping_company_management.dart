import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/admin/home_card.dart';
import 'package:app/design_system/atoms/admin/listing_card.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/or.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/shipping_provider.dart';
import 'package:app/screens/admin/shipping_company_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

class ShippingCompanyManagement extends StatefulWidget {
  @override
  _ShippingCompanyManagementState createState() => _ShippingCompanyManagementState();
}

class _ShippingCompanyManagementState extends State<ShippingCompanyManagement> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ShippingProvider shippingProvider;
  FocusNode searchFocusNode = new FocusNode();
  final f = new DateFormat('dd/MM/yyyy');

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
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "ShippingCompanyManagement.header"),
            style: FontStyles.header(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: Consumer<ShippingProvider>(
          builder: (BuildContext context, ShippingProvider model, Widget child) => FutureBuilder(
            future: model.getShippingCompanies(),
            builder: (BuildContext context, AsyncSnapshot<List<ListingShippingCompaniesOutputDTO>> snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AdminHomeCard(
                    boxColor: PColors.green1,
                    boxIcon: PIcons.addcustomer,
                    text: FlutterI18n.translate(context, "ShippingCompanyManagement.addCompany"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShippingCompanyAdd(
                              isEditable: true,
                              showSnackBar: showSnackBar,
                            ),
                          ));
                    },
                  ),
                  SizedBox(height: 24),
                  Or(),
                  SizedBox(height: 24),
                  Text(FlutterI18n.translate(context, "ShippingCompanyManagement.search"), style: FontStyles.header()),
                  SizedBox(height: 12),
                  Expanded(
                    child: snapshot.hasData
                        ? snapshot.data.length > 0
                            ? ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return AdminListingCard(
                                    imgUrl: snapshot.data[index].imageUrl,
                                    boxIcon: PIcons.favouritebook,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ShippingCompanyAdd(
                                              companyId: snapshot.data[index].companyId,
                                              isEditable: false,
                                              showSnackBar: showSnackBar,
                                            ),
                                          ));
                                    },
                                    children: <Widget>[
                                      Text(
                                        snapshot.data[index].name,
                                        style: FontStyles.bigTextField(),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        snapshot.data[index].contactNumber,
                                        style: FontStyles.textField(),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        f.format(snapshot.data[index].endDate),
                                        style: FontStyles.text(textColor: PColors.new_primary_button_b_y_ire_m),
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  FlutterI18n.translate(context, "ShippingCompanyManagement.noCompany"),
                                  textAlign: TextAlign.center,
                                  style: FontStyles.text(),
                                ),
                              )
                        : Loading(),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
