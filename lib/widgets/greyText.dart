import 'package:flutter/material.dart';

class GreyText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight fw;

  const GreyText({
    Key? key,
    required this.text,
    this.textColor,
    this.fontSize,
    this.fw = FontWeight.normal, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor ?? Colors.grey,
        fontSize: fontSize ?? 15,
        fontWeight: fw,
      ),
    );
  }
}
