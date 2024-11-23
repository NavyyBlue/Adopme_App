import 'dart:async';
import 'package:adopme_frontend/presentation/screens/auth/login/login_screen.dart';
import 'package:adopme_frontend/presentation/screens/auth/preferences/preferences_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adopme_frontend/services/auth_service.dart';

class EmailVerificationController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? idToken;

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  Future<void> sendEmailVerification() async {
    await auth.currentUser!.sendEmailVerification();
    Get.snackbar(
      "Email enviado",
      "Revisa tu bandeja de entrada para verificar tu email.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
    );
  }

  Future<void> checkEmailVerification() async {
    final currentUser = auth.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      idToken = await auth.currentUser!.getIdToken();
      AuthService.to.setIdToken(idToken!);
      Get.offAll(() => LoginScreen());
    } else {
      Get.snackbar(
        "Error",
        "Por favor verifica tu email.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          await FirebaseAuth.instance.currentUser?.reload();
          final user = FirebaseAuth.instance.currentUser;
          if (user?.emailVerified ?? false) {
            timer.cancel();
            idToken = await user!.getIdToken();
            AuthService.to.setIdToken(idToken!);
            Get.snackbar(
              "Email verificado",
              "Tu email ha sido verificado.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
              duration: Duration(seconds: 3),
            );
            Get.offAll(() => LoginScreen());
          }
        }
    );
  }
}
