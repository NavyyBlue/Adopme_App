import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../models/pet/pet_response.dart';
import '../../../../data/network/nestjs/user_profile_repository.dart';
import '../../../../models/user/user_profile.dart';

class AdoptionConfirmationController extends GetxController {
  final PetResponse pet;
  final UserProfileRepository userProfileRepository = UserProfileRepository();

  AdoptionConfirmationController(this.pet);

  void openWhatsApp() async {
    try {
      UserProfile userProfile = await fetchUserProfile(pet.reportingUserId!);
      final whatsappUrl = "https://wa.me/${userProfile.phoneNumber}?text=¡Hola!%20Estoy%20interesado%20en%20adoptar%20a%20${pet.name}.";
      if (await canLaunch(whatsappUrl)) {
        await launch(whatsappUrl);
      } else {
        Get.snackbar(
          'Error',
          'No se pudo abrir WhatsApp',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudo obtener el perfil del usuario',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<UserProfile> fetchUserProfile(String userId) async {
    try {
      return await userProfileRepository.getUserById(userId);
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudo obtener el perfil del usuario',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      rethrow;
    }
  }
}