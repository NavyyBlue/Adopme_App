import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:adopme_frontend/data/local/database_helper.dart';
import 'package:adopme_frontend/data/local/missing_pets_database_helper.dart';
import 'package:adopme_frontend/common/utils/utils.dart';

import '../../../../data/network/nestjs/analyzer_image_repository.dart';
import '../../../../models/analyzer_image/get_features_pet/get_features_pet_response.dart';

class ReportMissingPetController extends ChangeNotifier {
  final analyzerImageRepository = AnalyzerImageRepository();
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

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadImage() async {
    if (image == null) return;

    isUploading = true;
    notifyListeners();

    try {
      final base64Image = await utils.convertImageToBytes(image!);
      final fileName = 'missing_pet/${await utils.generateImageName(image!)}';
      responseData = await analyzerImageRepository.getFeaturesPet(fileName, base64Image);

      speciesController.text = responseData.species;
      breedController.text = responseData.breed;
      weightController.text = responseData.weight.toString();
      sizeController.text = responseData.size;
      ageController.text = responseData.age.toString();
      colorController.text = responseData.color;
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('Failed to upload image'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      isUploading = false;
      notifyListeners();
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
        locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final missingPet = {
      'name': nameController.text,
      'species': speciesController.text,
      'breed': breedController.text,
      'weight': double.tryParse(weightController.text) ?? 0.0,
      'size': sizeController.text,
      'age': int.tryParse(ageController.text) ?? 0,
      'color': colorController.text,
      'imageUrl': responseData.imageUrl,
      'description': descriptionController.text,
      'location': locationController.text,
    };

    await MissingPetsDatabaseHelper.insertMissingPet(await DatabaseHelper().database, missingPet);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Missing pet reported successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}