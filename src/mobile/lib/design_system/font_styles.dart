import 'package:flutter/material.dart';

class FontStyles {
  static TextStyle header({Color textColor}) => TextStyle(
        fontFamily: 'Quicksand',
        color: textColor ?? Color(0xffffffff),
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
      );

  static TextStyle bookHeader({Color textColor}) => TextStyle(
        fontFamily: 'Quicksand',
        color: textColor ?? Color(0xffffffff),
        fontSize: 28,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      );

  static TextStyle textField({Color textColor}) => TextStyle(
        fontFamily: 'Quicksand',
        color: textColor ?? Color(0xffa8afc0),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      );

  static TextStyle bigTextField({Color textColor}) => TextStyle(
        fontFamily: 'Quicksand',
        color: textColor ?? Color(0xffffffff),
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      );

  static TextStyle textFieldHighlighted({Color textColor}) => TextStyle(
        fontFamily: 'Quicksand',
        color: textColor ?? Color(0xffffffff),
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      );

  static TextStyle text({Color textColor}) => TextStyle(
        fontFamily: 'Quicksand',
        color: textColor ?? Color(0xffa8afc0),
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      );

  static TextStyle subText({Color textColor}) => TextStyle(
        fontFamily: 'Quicksand',
        color: textColor ?? Color(0xff0371fb),
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      );

  static TextStyle bigText({Color textColor}) => TextStyle(
        fontFamily: 'Quicksand',
        color: textColor ?? Color(0xffffffff),
        fontSize: 28,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      );

  static TextStyle smallText({Color textColor}) => TextStyle(
        fontFamily: 'Quicksand',
        color: textColor ?? Color(0xffffffff),
        fontSize: 12,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
      );

  static TextStyle smallTextRegular({Color textColor}) => TextStyle(
        fontFamily: 'Quicksand',
        color: textColor ?? Color(0xffffffff),
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      );
}
