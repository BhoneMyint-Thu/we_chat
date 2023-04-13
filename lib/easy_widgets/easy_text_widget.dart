import 'package:flutter/material.dart';

class EasyTextWidget extends StatelessWidget {
  const EasyTextWidget({Key? key, required this.text,this.color=Colors.white,this.fontSize=15,this.textDecor}) : super(key: key);

  final String text;
  final Color color;
  final double fontSize;
  final TextDecoration ? textDecor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        decoration: textDecor,
      color: color,
      fontSize: fontSize,
      overflow: TextOverflow.fade,
      // decoration: TextDecoration.underline,
    ),
    );
  }
}
