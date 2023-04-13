import 'package:flutter/material.dart';

class EasyTextFieldWidget extends StatelessWidget {
  const EasyTextFieldWidget({
    super.key,
    required this.hintText,
    this.controller,
    this.textInputType,
    this.focusNode
  });
  final String hintText;
  final TextEditingController ? controller;
  final TextInputType ? textInputType;
  final FocusNode ? focusNode;
  @override
  Widget build(BuildContext context) {
    return  TextField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: textInputType,
      decoration:  InputDecoration(
          hintText: hintText,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent))),
    );
  }
}