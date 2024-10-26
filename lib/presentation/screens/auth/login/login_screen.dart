import 'package:adopme_frontend/presentation/widgets/google_signin_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../component/textfield.dart';
import '../register/register_screen.dart';
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
                AuthTextField(
                  controller: controller.emailController,
                  labelText: 'Email',
                  validator: (value) {
                    if (!controller.validateEmail(value!)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                AuthTextField(
                  controller: controller.passwordController,
                  labelText: 'Contraseña',
                  obscureText: true,
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
                    Get.to(() => RegisterScreen());
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