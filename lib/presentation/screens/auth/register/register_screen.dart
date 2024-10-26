import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adopme_frontend/presentation/widgets/buttons/rounded_button.dart';
import 'package:google_fonts/google_fonts.dart';
import '../component/textfield.dart';
import 'register_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'AdoptMe',
                style: GoogleFonts.caveat(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Form(
                key: controller.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Registro',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[700],
                        ),
                      ),
                      SizedBox(height: 20),
                      AuthTextField(
                        controller: controller.nameController,
                        labelText: 'Nombre',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su nombre';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      AuthTextField(
                        controller: controller.lastNameController,
                        labelText: 'Apellido',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su apellido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      AuthTextField(
                        controller: controller.emailController,
                        labelText: 'Correo electrónico',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su correo electrónico';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      AuthTextField(
                        controller: controller.phoneController,
                        labelText: 'Número de celular',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su número de celular';
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
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su contraseña';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      RoundedButton(
                        text: 'Registrarse',
                        onPressed: () => controller.register(),
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
