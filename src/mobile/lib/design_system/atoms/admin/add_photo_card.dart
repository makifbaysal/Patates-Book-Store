import 'dart:io';

import 'package:app/design_system/p_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AddPhotoCard extends StatefulWidget {
  final VoidCallback onPressed;
  final String imageURL;
  final File image;
  final IconData icon;
  final bool isEditable;

  AddPhotoCard({Key key, this.onPressed, this.icon, this.imageURL, this.image, this.isEditable}) : super(key: key);

  @override
  _AddPhotoCardState createState() => _AddPhotoCardState();
}

class _AddPhotoCardState extends State<AddPhotoCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isEditable ? widget.onPressed : null,
      child: ClipRRect(
        borderRadius: widget.image != null ? BorderRadius.circular(20) : BorderRadius.circular(0),
        child: Container(
          width: 150,
          height: 224,
          child: (widget.image == null && widget.imageURL == null)
              ? Icon(widget.icon, size: 80, color: PColors.white)
              : widget.image != null ? Image.file(widget.image, fit: BoxFit.cover) : null,
          decoration: BoxDecoration(
              borderRadius: widget.image == null ? BorderRadius.circular(20) : null,
              border: (widget.image == null && widget.imageURL == null)
                  ? Border(
                      top: BorderSide(width: 2, color: Color(0xFFFFFFFFFF)),
                      right: BorderSide(width: 2, color: Color(0xFFFFFFFFFF)),
                      bottom: BorderSide(width: 2, color: Color(0xFFFFFFFFFF)),
                      left: BorderSide(width: 2, color: Color(0xFFFFFFFFFF)),
                    )
                  : null,
              image: widget.imageURL != null ? DecorationImage(image: CachedNetworkImageProvider(widget.imageURL), fit: BoxFit.cover) : null),
        ),
      ),
    );
  }
}
