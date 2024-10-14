import 'package:flutter/material.dart';

class RegisterPetTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? suffixText;
  final bool enabled;
  final TextInputType keyboardType;
  final Color fillColor;
  final Color textColor;
  final Color suffixTextColor;
  final int maxLines;

  const RegisterPetTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixText,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    required this.fillColor,
    required this.textColor,
    required this.suffixTextColor,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        suffixText: suffixText,
        suffixStyle: TextStyle(color: suffixTextColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: fillColor,
      ),
      style: TextStyle(
        color: textColor,
        fontSize: 16,
      ),
      enabled: enabled,
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }
}