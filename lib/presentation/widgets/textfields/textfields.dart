import 'package:flutter/material.dart';
import 'package:adopme_frontend/styles/colors.dart' as app_colors;

class RegisterPetTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? suffixText;
  final bool enabled;
  final TextInputType keyboardType;

  const RegisterPetTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixText,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        suffixText: suffixText,
        suffixStyle: const TextStyle(color: app_colors.Colors.suffixTextTextFieldRegisterPetColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: app_colors.Colors.backgroundTextFieldRegisterPetColor,
      ),
      style: const TextStyle(
        color: app_colors.Colors.textTextFieldRegisterPetColor,
        fontSize: 16,
      ),
      enabled: enabled,
      keyboardType: keyboardType,
    );
  }
}