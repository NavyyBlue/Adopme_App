import 'package:flutter/material.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    final email = emailController.text;
    final password = passwordController.text;

    if (_validateEmail(email) && _validatePassword(password)) {
      print('Iniciando sesión con $email y $password');
    } else {
      print('Email o contraseña no válidos');
    }
  }

  bool _validateEmail(String email) {
    return email.isNotEmpty && email.contains('@');
  }

  bool _validatePassword(String password) {
    return password.isNotEmpty && password.length > 6;
  }
}
