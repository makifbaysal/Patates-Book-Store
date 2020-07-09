import 'package:flutter/material.dart';

import '../font_styles.dart';
import '../p_colors.dart';

class PButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool loading;
  final Color color;
  final IconData icon;

  const PButton({Key key, this.text, this.onPressed, this.loading = false, this.icon, this.color = PColors.new_primary_button_b_y_ire_m})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 61,
      child: RaisedButton(
        onPressed: onPressed,
        color: color,
        child: !loading
            ? icon != null
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        icon,
                        color: PColors.white,
                        size: 30,
                      ),
                      SizedBox(width: 8),
                      Text(
                        text,
                        style: FontStyles.header(),
                      ),
                    ],
                  )
                : Text(
                    text,
                    style: FontStyles.header(),
                  )
            : CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(PColors.white),
              ),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
