import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  const CustomTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(hintText: hintText),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
    );
  }
}
