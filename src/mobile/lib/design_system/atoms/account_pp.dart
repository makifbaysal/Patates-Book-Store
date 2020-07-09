import 'package:app/design_system/icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../p_colors.dart';

class AccountPP extends StatelessWidget {
  final String imgUrl;

  const AccountPP({Key key, this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      child: imgUrl == null ? Center(child: Icon(PIcons.account, size: 35, color: PColors.darkBackground)) : Container(),
      decoration: BoxDecoration(
        color: PColors.blueGrey,
        borderRadius: BorderRadius.circular(20),
        image: imgUrl != null ? DecorationImage(image: CachedNetworkImageProvider(imgUrl), fit: BoxFit.cover) : null,
      ),
    );
  }
}
