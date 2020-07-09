import 'package:app/design_system/p_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  PAppBar({
    Key key,
    @required this.title,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: PColors.cardDark,
      expandedHeight: 490.0,
      pinned: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.turned_in_not),
          onPressed: () {},
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      title: Text("Merhaba"),
      automaticallyImplyLeading: true,
      stretch: true,
      centerTitle: true,
      forceElevated: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text("Akif"),
        centerTitle: true,
        collapseMode: CollapseMode.pin,
        background: Container(
          decoration: BoxDecoration(
            color: PColors.cardDark,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          child: Column(
            children: <Widget>[
              Center(
                  child:
                      Container(height: 257, width: 176, child: Image.network("https://i.dr.com.tr/cache/600x600-0/originals/0000000064038-1.jpg")))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
