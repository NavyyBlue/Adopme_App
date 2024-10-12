import 'dart:io';
import 'package:adopme_frontend/data/network/nestjs/analyzer_image_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:adopme_frontend/common/utils/utils.dart';
import 'package:path/path.dart' as path;

import '../../../../data/local/database_helper.dart';

class RegisterPetController extends GetxController {
  final analyzerImageRepository = AnalyzerImageRepository();
  final utils = Utils();
  File? image;
  bool isUploading = false;
  var responseData;

  final nameController = TextEditingController();
  final speciesController = TextEditingController();
  final breedController = TextEditingController();
  final weightController = TextEditingController();
  final sizeController = TextEditingController();
  final ageController = TextEditingController();
  final colorController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
    }
  }

  Future<void> uploadImage() async {
    if (image == null) return;

    isUploading = true;
    update();

    try {
      final base64Image = await utils.convertImageToBytes(image!);
      final fileName = path.basename(image!.path);
      responseData = await analyzerImageRepository.getFeaturesPet(fileName, base64Image);

      speciesController.text = responseData.species;
      breedController.text = responseData.breed;
      weightController.text = responseData.weight.toString();
      sizeController.text = responseData.size;
      ageController.text = responseData.age.toString();
      colorController.text = responseData.color;
    } catch (e) {
      responseData = null;
      print('Upload failed: $e');
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
        colorController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final pet = {
      'name': nameController.text,
      'species': speciesController.text,
      'breed': breedController.text,
      'weight': double.tryParse(weightController.text) ?? 0.0,
      'size': sizeController.text,
      'age': int.tryParse(ageController.text) ?? 0,
      'color': colorController.text,
      'imageUrl': responseData?.imageUrl ?? '',
    };

    await DatabaseHelper().insertPet(pet);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pet registered successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}