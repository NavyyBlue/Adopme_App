import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const RoundedButton({
    required this.text,
    required this.onPressed,
    Color? backgroundColor,
    Color? textColor,
  })  : backgroundColor =
            backgroundColor ?? const Color(0xFF26A69A), //Colors.teal[400];
        textColor = textColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: backgroundColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: textColor,
        ),
      ),
    );
  }
}
