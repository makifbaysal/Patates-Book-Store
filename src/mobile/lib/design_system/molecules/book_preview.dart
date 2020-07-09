import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../font_styles.dart';
import '../p_colors.dart';

class BookPreview extends StatelessWidget {
  final String name;
  final double price;
  final String author;
  final String imgUrl;
  final VoidCallback onPressed;
  final double width;
  final bool isShowPrice;
  final bool isWeekly;

  const BookPreview(
      {Key key, this.name, this.price, this.author, this.imgUrl, this.onPressed, this.width, this.isShowPrice = true, this.isWeekly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 8, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: width,
              height: width * 1.4,
              decoration: BoxDecoration(
                  image: DecorationImage(image: CachedNetworkImageProvider(imgUrl), fit: BoxFit.cover), borderRadius: BorderRadius.circular(15)),
            ),
            SizedBox(
              height: 4,
            ),
            isShowPrice
                ? isWeekly
                    ? Row(
                        children: <Widget>[
                          Text(
                            "₺" + (1.2 * price).toString(),
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontFamily: 'Quicksand',
                              color: PColors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "₺" + price.toString(),
                            style: FontStyles.text(textColor: PColors.bright_blue),
                          ),
                        ],
                      )
                    : Text(
                        "₺" + price.toString(),
                        style: FontStyles.text(textColor: PColors.bright_blue),
                      )
                : Container(),
            SizedBox(
              height: 4,
            ),
            Text(
              name,
              style: FontStyles.text(textColor: PColors.white),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              author,
              style: FontStyles.textField(),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
