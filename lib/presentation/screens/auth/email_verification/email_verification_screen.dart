import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'email_verification_controller.dart';

class EmailVerificationScreen extends StatelessWidget {
  final EmailVerificationController controller = Get.put(EmailVerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verificación de Email'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Por favor verifica tu email.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await controller.sendEmailVerification();
              },
              child: Text('Reenviar Email de Verificación'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await controller.checkEmailVerification();
              },
              child: Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}