// compare_image_controller.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../common/utils/utils.dart';
import '../../../../data/network/nestjs/pet_repository.dart';

class CompareImageController extends GetxController {
  final PetRepository petRepository;
  File? image;
  bool isUploading = false;
  bool isComparisonSuccessful = false;
  String comparisonResultMessage = 'Aqui se mostrará el resultado de la comparación entre la imagen elegida y la imagen de la mascota de reportada';
  final utils = Utils();

  CompareImageController(this.petRepository);

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
    }
  }

  Future<void> uploadImage(BuildContext context, String imageUrl) async {
    if (image == null) return;

    isUploading = true;
    update();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Subiendo imagen...'),
            ],
          ),
        );
      },
    );

    try {
      final base64Image = await utils.convertImageToBytes(image!);
      final fileName = 'compare_pet/${await utils.generateImageName(image!)}';
      final response = await petRepository.comparePets(fileName, base64Image, imageUrl);
      if (response['status'] == 200) {
        isComparisonSuccessful = true;
        comparisonResultMessage = response['message'];
      } else {
        isComparisonSuccessful = false;
        comparisonResultMessage = response['message'];
      }
    } catch (e) {
      isComparisonSuccessful = false;
      comparisonResultMessage = 'Error al subir la imagen.';
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
      Navigator.of(context).pop(); // Close the dialog
    }
  }
}