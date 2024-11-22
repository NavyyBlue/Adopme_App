import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdoptionFormController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dniController = TextEditingController();

  var acceptTerms = false.obs;

  void toggleAcceptTerms(bool value) {
    acceptTerms.value = value;
  }

  void submitForm() {
    print('Formulario enviado:');
    print('Nombre: ${nameController.text}');
    print('Apellido: ${lastNameController.text}');
    print('Correo: ${emailController.text}');
    print('Teléfono: ${phoneController.text}');
    print('Dirección: ${addressController.text}');
    print('DNI: ${dniController.text}');
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    dniController.dispose();
    super.dispose();
  }
}