import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/icons.dart';
import 'package:app/screens/order_address.dart';
import 'package:flutter/material.dart';

import '../p_colors.dart';

class AddressBox extends StatelessWidget {
  final String addressID;
  final String address;
  final String city;
  final String county;
  final VoidCallback onPressed;
  final bool isActive;

  AddressBox({Key key, this.address, this.city, this.county, this.isActive = false, this.addressID, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        height: 120,
        width: 320,
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: isActive ? PColors.green1 : PColors.cardDark,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    address,
                    style: FontStyles.bigTextField(textColor: PColors.white),
                    maxLines: 2,
                    softWrap: true,
                  ),
                ),
                GestureDetector(
                  child: Icon(
                    PIcons.edit,
                    color: PColors.white,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OrderAddress(addressID: addressID)));
                  },
                )
              ],
            ),
            Text(
              county + " / " + city,
              style: FontStyles.text(textColor: PColors.white),
            )
          ],
        ),
      ),
    );
  }
}
