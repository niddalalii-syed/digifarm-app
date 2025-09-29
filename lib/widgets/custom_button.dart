// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final Color color;
  final Color? textcolor;
  final BorderRadiusGeometry? borderRadius;
  final FontWeight? fontWeight;
  final double? width;
  final double? height;
  final double? fontSize;
  const CustomButton({
    Key? key,
    required this.title,
    required this.color,
    this.textcolor,
    this.borderRadius,
    this.fontWeight,
    this.width,
    this.height,
    this.fontSize,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 40,
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(20)),
      width: widget.width ?? 146,
      child: Center(
          child: Text(
        widget.title,
        style: TextStyle(
            color: widget.textcolor ?? Colors.white,
            fontSize: widget.fontSize?? 18,
            fontWeight: widget.fontWeight ?? FontWeight.bold),
      )),
    );
  }
}
