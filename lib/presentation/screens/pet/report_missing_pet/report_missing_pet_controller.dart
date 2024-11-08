import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:adopme_frontend/data/local/database_helper.dart';
import 'package:adopme_frontend/data/local/missing_pets_database_helper.dart';
import 'package:adopme_frontend/common/utils/utils.dart';

import '../../../../data/network/nestjs/analyzer_image_repository.dart';
import '../../../../models/analyzer_image/get_features_pet/get_features_pet_response.dart';

import 'package:adopme_frontend/data/network/nestjs/pet_repository.dart';
import 'package:adopme_frontend/models/pet/create_pet.dart';

class ReportMissingPetController extends GetxController {
  final analyzerImageRepository = AnalyzerImageRepository();
  final petRepository = PetRepository();
  File? image;
  bool isUploading = false;
  late GetFeaturesPetResponse responseData;
  final utils = Utils();

  final nameController = TextEditingController();
  final speciesController = TextEditingController();
  final breedController = TextEditingController();
  final weightController = TextEditingController();
  final sizeController = TextEditingController();
  final ageController = TextEditingController();
  final colorController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final genderController = TextEditingController(); // New controller for sexo

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
    }
  }

  Future<void> uploadImage(BuildContext context) async {
    if (image == null) return;

    isUploading = true;
    update();

    try {
      final base64Image = await utils.convertImageToBytes(image!);
      final fileName = 'missing_pet/${await utils.generateImageName(image!)}';
      responseData =
      await analyzerImageRepository.getFeaturesPet(fileName, base64Image);

      speciesController.text = responseData.species;
      breedController.text = responseData.breed;
      weightController.text = responseData.weight.toString();
      sizeController.text = responseData.size;
      ageController.text = responseData.age.toString();
      colorController.text = responseData.color;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error uploading image'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isUploading = false;
      update();
    }
  }

  Future<void> reportMissingPet(BuildContext context) async {
    if (nameController.text.isEmpty ||
        speciesController.text.isEmpty ||
        breedController.text.isEmpty ||
        weightController.text.isEmpty ||
        sizeController.text.isEmpty ||
        ageController.text.isEmpty ||
        colorController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        locationController.text.isEmpty ||
        genderController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final createPet = CreatePet(
      name: nameController.text,
      weight: weightController.text,
      size: sizeController.text,
      species: speciesController.text,
      breed: breedController.text,
      age: ageController.text,
      gender: genderController.text,
      description: descriptionController.text,
      location: locationController.text,
      color: colorController.text,
      imageUrl: responseData.imageUrl,
      reportingUserId: '', // Add reportingUserId if needed
    );

    try {
      await petRepository.createPet(createPet, true); // Pass true for isMissing
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Missing pet reported successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to report missing pet'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
