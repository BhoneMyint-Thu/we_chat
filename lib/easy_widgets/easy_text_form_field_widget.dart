import 'package:flutter/material.dart';

class EasyTextFormFieldWidget extends StatelessWidget {
  const EasyTextFormFieldWidget({Key? key,
    required this.validatorText,
    required this.controller,
    required this.hintText,
    this.obscure=false,
    this.suffixIcon
  }) : super(key: key);

  final TextEditingController controller;
  final String validatorText;
  final String hintText;
  final bool obscure;
  final Widget ? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return validatorText;
        }
        return null;
      },
      decoration:  InputDecoration(
          hintText: hintText,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          suffixIcon: suffixIcon,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent))),
    );
  }
}
