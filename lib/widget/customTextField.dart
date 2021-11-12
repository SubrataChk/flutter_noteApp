import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextStyle fontStyle;
  final int lineHeight;
  final TextEditingController controller;

  const CustomTextFormField(
      {Key? key,
      required this.fontStyle,
      required this.lineHeight,
      required this.hintText,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: 20),
      child: TextFormField(
        controller: controller,
        style: fontStyle,
        maxLines: lineHeight,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 2),
          ),
        ),
      ),
    );
  }
}
