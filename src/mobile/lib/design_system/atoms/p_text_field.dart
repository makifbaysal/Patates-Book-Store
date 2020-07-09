import 'package:flutter/material.dart';

import '../font_styles.dart';
import '../p_colors.dart';

class PTextField extends StatefulWidget {
  final String placeholderText;
  final IconData suffixIcon;
  final TextEditingController controller;
  final VoidCallback onPressed;
  final bool showPassword;
  final FocusNode focusNode;
  final Function requestFocus;
  final TextInputType keyboardType;
  final Function(String) validator;
  final int maxLine;
  final bool enabled;

  PTextField(
      {Key key,
      this.placeholderText,
      this.controller,
      this.suffixIcon,
      this.onPressed,
      this.showPassword,
      this.focusNode,
      this.requestFocus,
      this.keyboardType,
      this.validator,
      this.maxLine = 1,
      this.enabled = true})
      : super(key: key);

  @override
  _PTextFieldState createState() => _PTextFieldState();
}

class _PTextFieldState extends State<PTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        widget.requestFocus(widget.focusNode);
      },
      controller: widget.controller,
      autofocus: false,
      enabled: widget.enabled,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
      maxLines: widget.maxLine,
      obscureText: widget.showPassword == null ? false : !widget.showPassword,
      style: FontStyles.textField(textColor: PColors.white),
      decoration: InputDecoration(
          hintText: widget.placeholderText,
          fillColor: widget.focusNode.hasFocus ? PColors.cardLightBackground : PColors.cardDark,
          filled: true,
          errorStyle: FontStyles.smallText(),
          hintStyle: FontStyles.textField(),
          border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(15),
              ),
              borderSide: BorderSide(color: widget.focusNode.hasFocus ? PColors.cardLightBackground : PColors.cardDark)),
          focusedBorder: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(15),
              ),
              borderSide: BorderSide(color: widget.focusNode.hasFocus ? PColors.cardLightBackground : PColors.cardDark)),
          suffixIcon: widget.suffixIcon == null
              ? null
              : IconButton(
                  icon: Icon(widget.suffixIcon, color: PColors.blueGrey),
                  onPressed: widget.onPressed,
                ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
          errorMaxLines: 2),
    );
  }
}
