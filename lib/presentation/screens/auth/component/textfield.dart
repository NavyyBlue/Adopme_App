import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final ValueNotifier<bool> showPassword;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.validator,
    required this.showPassword,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: showPassword,
      builder: (context, value, child) {
        return TextFormField(
          controller: controller,
          obscureText: obscureText && !value,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.teal[700]!),
            filled: true,
            fillColor: Colors.teal[50]!,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            suffixIcon: obscureText
                ? IconButton(
              icon: Icon(
                value ? Icons.visibility : Icons.visibility_off,
                color: Colors.teal[700]!,
              ),
              onPressed: () {
                showPassword.value = !showPassword.value;
              },
            )
                : null,
          ),
          style: TextStyle(color: Colors.teal[700]!),
          validator: validator,
        );
      },
    );
  }
}