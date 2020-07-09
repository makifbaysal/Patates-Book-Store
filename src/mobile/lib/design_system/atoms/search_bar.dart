import 'package:app/design_system/icons.dart';
import 'package:flutter/material.dart';

import '../font_styles.dart';
import '../p_colors.dart';

class SearchBar extends StatefulWidget {
  final String placeholderText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function requestFocus;
  final TextInputType keyboardType;
  final Function(String) onChange;

  const SearchBar({Key key, this.placeholderText, this.controller, this.focusNode, this.requestFocus, this.keyboardType, this.onChange})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        onTap: () {
          widget.requestFocus(widget.focusNode);
        },
        onChanged: widget.onChange,
        controller: widget.controller,
        autofocus: false,
        keyboardType: widget.keyboardType,
        focusNode: widget.focusNode,
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
          suffixIcon: GestureDetector(
            child: Icon(PIcons.search, color: PColors.blueGrey),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        ),
      ),
    );
  }
}
