import 'dart:async';

import 'package:adopme_frontend/data/network/nestjs/user_profile_repository.dart';
import 'package:adopme_frontend/models/user/create_user_profile_payload.dart';
import 'package:adopme_frontend/presentation/screens/auth/email_verification/email_verification_screen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final userProfileRepository = UserProfileRepository();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      try {
        validatePhoneNumber();
        await verifyEmail();

        await auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        ).then((value) async {
          value.user!.updateDisplayName("${nameController.text} ${lastNameController.text}");
        });
        await userProfileRepository.createUserProfile(CreateUserProfile(
            userId: auth.currentUser!.uid,
            phoneNumber: phoneController.text
        ));
        //auth.currentUser!.sendEmailVerification();
        Get.offAll(() => EmailVerificationScreen());
      } on FirebaseAuthException catch (e) {
        Get.snackbar(
          "Error",
          e.message ?? "Unknown error",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }
    }
  }

  Future<void> verifyEmail() async {
    try {
      await userProfileRepository.verifyEmail(emailController.text);
    } on DioException catch (e) {
      if (e.response!.data['message'] == 'invalid-email') {
        Get.snackbar("Error", "Ingresa un correo institucional válido",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
            duration: Duration(seconds: 3));
      } else {
        Get.snackbar("Error", "Error desconocido",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
            duration: Duration(seconds: 3));
      }
      rethrow;
    } on TimeoutException catch (_) {
      throw Exception('Time out');
    }
  }

  String validatePhoneNumber() {
    final phoneNumber = phoneController.text;
    final peruPhoneRegex = RegExp(r'^\+51\d{9}$');
    if (peruPhoneRegex.hasMatch(phoneNumber)) {
      return phoneNumber;
    }

    final formattedPhoneNumber = '+51$phoneNumber';
    if (peruPhoneRegex.hasMatch(formattedPhoneNumber)) {
      return formattedPhoneNumber;
    }

    Get.snackbar(
      "Error",
      "No has ingresado un número de teléfono válido",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
    );
    throw Exception("Número de teléfono no válido");
  }

  @override
  void onClose() {
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}