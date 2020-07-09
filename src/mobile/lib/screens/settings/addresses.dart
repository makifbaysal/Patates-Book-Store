import 'package:app/design_system/atoms/admin/app_bar.dart';
import 'package:app/design_system/atoms/loading.dart';
import 'package:app/design_system/atoms/settings_address_box.dart';
import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:app/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:openapi/api.dart';
import 'package:provider/provider.dart';

import '../order_address.dart';

class SettingsAddresses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.darkBackground,
      appBar: PAppBar(
        isCenter: true,
        children: <Widget>[
          Text(
            FlutterI18n.translate(context, "SettingsAddresses.header"),
            style: FontStyles.header(),
          ),
        ],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: PColors.white,
            iconSize: 25,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderAddress()));
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Consumer<UserProvider>(
              builder: (BuildContext context, model, Widget child) {
                return FutureBuilder(
                  future: model.getUserAddress(),
                  builder: (BuildContext context, AsyncSnapshot<List<ListAddressOutputDTO>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          padding: EdgeInsets.all(24),
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => SettingsAddressBox(
                            addressID: snapshot.data[index].addressId,
                            header: snapshot.data[index].header,
                            address: snapshot.data[index].address,
                          ),
                        );
                      }
                      return Center(
                        child: Text(
                          FlutterI18n.translate(context, "SettingsAddresses.noAddress"),
                          style: FontStyles.text(),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return Loading();
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
