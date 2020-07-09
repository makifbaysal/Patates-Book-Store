import 'package:app/design_system/p_colors.dart';
import 'package:flutter/material.dart';

class PCard extends StatelessWidget {
  final Widget child;

  const PCard({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PColors.cardDark,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: child,
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
    );
  }
}
