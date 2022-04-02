import 'package:flutter/material.dart';
import 'package:trashtogether/utils/colors.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final TextInputType inputType;
  const TextInputField(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.inputType,
      this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(30));
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        fillColor: inputColor,
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      ),
      keyboardType: inputType,
    );
  }
}
