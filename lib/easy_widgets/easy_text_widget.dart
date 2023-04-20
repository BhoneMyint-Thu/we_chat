import 'package:flutter/material.dart';

class EasyTextWidget extends StatelessWidget {
  const EasyTextWidget({Key? key, required this.text,this.color=Colors.white,this.fontSize=15,this.textDecor,this.overflow=TextOverflow.fade}) : super(key: key);

  final String text;
  final Color color;
  final double fontSize;
  final TextDecoration ? textDecor;
  final TextOverflow  overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        decoration: textDecor,
      color: color,
      fontSize: fontSize,
      overflow:overflow,
      // decoration: TextDecoration.underline,
    ),
    );
  }
}
