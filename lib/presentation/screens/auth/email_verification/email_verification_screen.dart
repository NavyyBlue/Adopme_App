import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'email_verification_controller.dart';

class EmailVerificationScreen extends StatelessWidget {
  final EmailVerificationController controller = Get.put(EmailVerificationController());

  @override
  Widget build(BuildContext context) {
    final String email = controller.auth.currentUser?.email ?? 'tu correo';

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Verifica tu email',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  text: 'Sigue el enlace que enviamos a ',
                  style: TextStyle(fontSize: 18),
                  children: <TextSpan>[
                    TextSpan(
                      text: email,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Image.asset('assets/images/mail_icon.png', height: 150),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await controller.checkEmailVerification();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                ),
                child: Text(
                  'Continuar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  await controller.sendEmailVerification();
                },
                child: Text(
                  'Reenviar Email de Verificación',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}