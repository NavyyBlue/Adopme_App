import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/utils/utils.dart';
import '../../../../data/network/nestjs/analyzer_image_repository.dart';
import '../../../../data/network/nestjs/pet_repository.dart';
import '../../../../models/analyzer_image/get_features_pet/get_features_pet_response.dart';
import '../../../../models/pet/pet_response.dart';
import 'dart:io';

class PetListController extends GetxController {

  final analyzerImageRepository = AnalyzerImageRepository();
  final utils = Utils();
  File? image;
  bool isUploading = false;
  late GetFeaturesPetResponse responseData;

  var isLoading = true.obs;
  var isFilterMenuOpen = false.obs;
  var filteredPets = <PetResponse>[].obs;

  final petRepository = PetRepository();
  var adoptingPets = <PetResponse>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAdoptingPets();
  }

  Future<void> fetchAdoptingPets() async {
    try {
      isLoading(true);
      var pets = await petRepository.getPets(isMissing: false);
      adoptingPets.assignAll(pets);
      filteredPets.assignAll(pets);
    } catch (e) {
      print('Failed to fetch adopting pets: $e');
    } finally {
      isLoading(false);
    }
  }

  void toggleFilterMenu() {
    isFilterMenuOpen(!isFilterMenuOpen.value);
  }

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

      print('ImageUrl: ${responseData.imageUrl}');
      print('Breed: ${responseData.breed}');
      print('Weight: ${responseData.weight}');
      print('Size: ${responseData.size}');
      print('Age: ${responseData.age}');
      print('Color: ${responseData.color}');
      print('Species: ${responseData.species}');

      // Call getPets with the obtained characteristics
      var pets = await petRepository.getPets(
        breed: responseData.breed,
        // weight: responseData.weight.toString(),
        // size: responseData.size,
        // age: responseData.age.toString(),
        // color: responseData.color,
        species: responseData.species,
      );

      filteredPets.assignAll(pets);

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
}