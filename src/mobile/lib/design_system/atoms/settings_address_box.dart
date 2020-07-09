import 'package:app/screens/order_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../font_styles.dart';
import '../p_colors.dart';

class SettingsAddressBox extends StatefulWidget {
  final String addressID;
  final String header;
  final String address;

  SettingsAddressBox({Key key, this.addressID, this.header, this.address}) : super(key: key);

  @override
  _SettingsAddressBoxState createState() => _SettingsAddressBoxState();
}

class _SettingsAddressBoxState extends State<SettingsAddressBox> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  showSnackBar(String message) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PColors.cardDark,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.header,
                  style: FontStyles.bigTextField(),
                ),
              )
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.address,
                  style: FontStyles.text(),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: <Widget>[
              Container(
                height: 28,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderAddress(addressID: widget.addressID, showSnackBar: showSnackBar),
                        ));
                  },
                  color: PColors.new_primary_button_b_y_ire_m,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        FlutterI18n.translate(context, "SettingsAddressBox.details"),
                        style: FontStyles.smallText(textColor: PColors.white),
                      )
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
