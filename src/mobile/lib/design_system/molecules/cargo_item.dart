import 'package:flutter/material.dart';

import '../font_styles.dart';
import '../p_colors.dart';

class CargoItem extends StatelessWidget {
  final Function radio;
  final int value;
  final int index;
  final String name;
  final double price;

  const CargoItem({Key key, this.radio, this.value, this.name, this.price, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: PColors.blueGrey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Radio(
                  onChanged: (int e) => radio(e),
                  activeColor: PColors.green1,
                  value: index,
                  groupValue: value,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
              Text(
                name,
                style: FontStyles.text(textColor: PColors.blueGrey),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              "₺" + price.toString(),
              style: FontStyles.smallText(textColor: PColors.blueGrey),
            ),
          )
        ],
      ),
    );
  }
}
