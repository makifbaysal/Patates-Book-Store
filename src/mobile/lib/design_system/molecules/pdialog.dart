import 'package:app/design_system/p_colors.dart';
import 'package:flutter/material.dart';

class PDialog extends StatelessWidget {
  final List<Widget> children;

  const PDialog({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(32),
        decoration: new BoxDecoration(
          color: PColors.darkBackground,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: children),
      ),
    );
  }
}
