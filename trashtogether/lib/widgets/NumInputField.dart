import 'package:flutter/material.dart';
import 'package:trashtogether/utils/colors.dart';

class NumInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;
  const NumInputField(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.inputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context),
        borderRadius: BorderRadius.circular(5));
    return TextField(
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        fillColor: buttonColor,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.only(top: 4),
      ),
      keyboardType: inputType,
    );
  }
}
