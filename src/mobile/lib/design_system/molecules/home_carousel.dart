import 'package:flutter/material.dart';

import '../font_styles.dart';

class HomeCarousel extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const HomeCarousel({Key key, this.title, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: FontStyles.header(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          height: 335,
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: children,
          ),
        )
      ],
    );
  }
}
