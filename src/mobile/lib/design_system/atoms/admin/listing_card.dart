import 'package:app/design_system/font_styles.dart';
import 'package:app/design_system/p_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AdminListingCard extends StatelessWidget {
  final IconData boxIcon;
  final String imgUrl;
  final VoidCallback onPressed;
  final List<Widget> children;
  final Widget bottomRightWidget;
  final bool commentAllowed;
  final Widget commentOnTap;

  const AdminListingCard(
      {Key key, this.boxIcon, this.imgUrl, this.onPressed, this.children, this.bottomRightWidget, this.commentAllowed = false, this.commentOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: PColors.cardDark),
          child: Stack(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 96,
                    decoration: BoxDecoration(
                      image: imgUrl != null
                          ? DecorationImage(
                              image: CachedNetworkImageProvider(imgUrl),
                              fit: BoxFit.cover,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: (imgUrl == null)
                        ? Center(
                            child: Icon(
                              boxIcon,
                              size: 70,
                              color: PColors.white,
                            ),
                          )
                        : null,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children,
                    ),
                  )
                ],
              ),
              bottomRightWidget != null
                  ? Positioned(
                      bottom: 0,
                      right: 0,
                      child: bottomRightWidget,
                    )
                  : Container(),
              commentAllowed
                  ? Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => commentOnTap,
                              ));
                        },
                        child: Text(
                          "Yorum Yap",
                          style: FontStyles.smallTextRegular(textColor: PColors.white),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
