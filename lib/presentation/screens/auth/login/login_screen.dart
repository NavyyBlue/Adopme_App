import 'package:adopme_frontend/presentation/widgets/google_signin_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';
import 'package:adopme_frontend/presentation/widgets/buttons/rounded_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/cat.png',
                  height: 220,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
                Text(
                  'Inicio sesión',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[700],
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.teal[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (!controller.validateEmail(value!)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    filled: true,
                    fillColor: Colors.teal[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (!controller.validatePassword(value!)) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                RoundedButton(
                  text: 'Iniciar sesión',
                  onPressed: () => controller.login(),
                ),
                SizedBox(height: 20),
                Text(
                  'O',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                GoogleSignInButton(
                  onPressed: () => controller.signInWithGoogle(),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Navegar a la pantalla de registro
                  },
                  child: Text(
                    '¿No tienes cuenta? Regístrate',
                    style: TextStyle(
                      color: Colors.teal[300],
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}