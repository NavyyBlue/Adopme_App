import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/network/nestjs/adoptions_forms_repository.dart';
import '../../../../models/adoptions_forms/adoptions_forms_request.dart';

class AdoptionFormController extends GetxController {

  final adoptionFormRepository = AdoptionsFormsRepository();

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

  Future<bool> submitForm(String petId) async {
    if (nameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty ||
        dniController.text.isEmpty) {
      Get.snackbar('Error', 'Todos los campos son obligatorios');
      return false;
    }

    if (nameController.text.length < 1) {
      Get.snackbar('Error', 'El nombre debe tener al menos un carácter');
      return false;
    }

    if (lastNameController.text.length < 1) {
      Get.snackbar('Error', 'El apellido debe tener al menos un carácter');
      return false;
    }

    if (!emailController.text.endsWith('@unmsm.edu.pe')) {
      Get.snackbar('Error', 'El correo electrónico debe tener el dominio @unmsm.edu.pe');
      return false;
    }

    if (!RegExp(r'^\d{9}$').hasMatch(phoneController.text)) {
      Get.snackbar('Error', 'El teléfono debe tener 9 dígitos y solo puede contener números');
      return false;
    }

    if (addressController.text.length < 1) {
      Get.snackbar('Error', 'La dirección debe tener al menos un carácter');
      return false;
    }

    if (!RegExp(r'^\d{8}$').hasMatch(dniController.text)) {
      Get.snackbar('Error', 'El DNI debe tener 8 dígitos');
      return false;
    }

    var request = CreateAdoptionForm(
      name: nameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      phone: '+51${phoneController.text}',
      address: addressController.text,
      dni: dniController.text,
      petId: petId,
    );

    try {
      await adoptionFormRepository.createAdoptionsForm(request);
      Get.snackbar('Éxito', 'Formulario enviado correctamente');
      return true;
    } catch (error) {
      Get.snackbar('Error', error.toString());
      return false;
    }
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