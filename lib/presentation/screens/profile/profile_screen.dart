import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adopme_frontend/presentation/screens/auth/login/login_controller.dart';
import 'package:adopme_frontend/presentation/screens/auth/login/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final controller = Get.find<LoginController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user != null) ...[
              Text(
                'Nombre: ${user.displayName ?? 'No disponible'}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                'Email: ${user.email ?? 'No disponible'}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.signOut();
                  Get.offAll(() => LoginScreen());
                },
                child: Text('Cerrar sesión'),
              ),
            ] else ...[
              Text(
                'No hay usuario logeado',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ],
        ),
      ),
    );
  }
}