import 'dart:io';
import 'package:adopme_frontend/data/network/nestjs/analyzer_image_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:adopme_frontend/common/utils/utils.dart';
import '../../../../data/network/nestjs/pet_repository.dart';
import '../../../../models/analyzer_image/get_features_pet/get_features_pet_response.dart';
import '../../../../models/pet/create_pet.dart';

class RegisterPetController extends GetxController {
  final analyzerImageRepository = AnalyzerImageRepository();
  final petRepository = PetRepository();
  FirebaseAuth auth = FirebaseAuth.instance;
  final utils = Utils();
  File? image;
  bool isUploading = false;
  late GetFeaturesPetResponse responseData;

  final nameController = TextEditingController();
  final speciesController = TextEditingController();
  final breedController = TextEditingController();
  final weightController = TextEditingController();
  final sizeController = TextEditingController();
  final ageController = TextEditingController();
  final colorController = TextEditingController();
  final genderController = TextEditingController();

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
      final fileName = 'pet/${await utils.generateImageName(image!)}';
      responseData = await analyzerImageRepository.getFeaturesPet(fileName, base64Image);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image uploaded successfully')),
        );
      }

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
            content: Text('Failed to upload image'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      isUploading = false;
      update();
    }
  }

  Future<void> registerPet(BuildContext context) async {
    if (nameController.text.isEmpty ||
        speciesController.text.isEmpty ||
        breedController.text.isEmpty ||
        weightController.text.isEmpty ||
        sizeController.text.isEmpty ||
        ageController.text.isEmpty ||
        colorController.text.isEmpty ||
        genderController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String? userId = auth.currentUser!.uid;

    print('Create pet userId: $userId');

    final createPet = CreatePet(
      name: nameController.text,
      weight: weightController.text,
      size: sizeController.text,
      species: speciesController.text,
      breed: breedController.text,
      age: ageController.text,
      gender: genderController.text,
      description: '', // Add description if needed
      location: '', // Add location if needed
      color: colorController.text,
      imageUrl: responseData.imageUrl,
      reportingUserId: userId, // Add reportingUserId if needed
    );

    try {
      await petRepository.createPet(createPet, false); // Pass the appropriate value for isMissing
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pet registered successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to register pet'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}