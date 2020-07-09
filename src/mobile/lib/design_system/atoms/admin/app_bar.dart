import 'package:app/design_system/p_colors.dart';
import 'package:flutter/material.dart';

class PAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isCenter;
  final List<Widget> actions;
  final List<Widget> children;
  final IconButton leading;

  const PAppBar({Key key, this.isCenter = false, this.actions, this.children, this.leading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: PColors.cardDark,
      elevation: 0,
      leading: leading,
      centerTitle: isCenter,
      actions: actions != null
          ? <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: Row(
                  children: actions,
                ),
              )
            ]
          : null,
      title: Column(
        children: children,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
