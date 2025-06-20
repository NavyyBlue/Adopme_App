import 'package:adopme_frontend/data/network/nestjs/preferences_repository.dart';
import 'package:adopme_frontend/models/preferences/preferences_model.dart';
import 'package:adopme_frontend/presentation/screens/home/home_screen.dart';
import 'package:adopme_frontend/presentation/screens/profile/profile_screen.dart';
import 'package:adopme_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreferencesController extends GetxController {
  final preferencesRepository = PreferencesRepository();
  final userService = UserService.to;

  Future<PetPreferences?> getPreferences() async {
    try {
      final userProfile = await userService.userProfileRepository.getUserProfile();
      return userProfile.petPreferences;
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudieron obtener las preferencias',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return null;
  }

  Future<void> addPreferences(PetPreferences petPreferences) async {
    try {
      await preferencesRepository.createPreferences(petPreferences);
      Get.snackbar(
        'Éxito',
        'Preferencias guardadas correctamente',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAll(() => HomeScreen());
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudieron guardar las preferencias',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> updatePreferences(PetPreferences petPreferences) async {
    try {
      await preferencesRepository.updatePreferences(petPreferences);
      Get.snackbar(
        'Éxito',
        'Preferencias actualizadas correctamente',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAll(() => ProfileScreen());
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudieron actualizar las preferencias',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}