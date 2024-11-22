import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AdoptionConfirmationController extends GetxController {
  void openWhatsApp() async {
    const whatsappUrl = "https://wa.me/?text=¡Hola!%20Estoy%20interesado%20en%20adoptar%20una%20mascota.";
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
  }
}
