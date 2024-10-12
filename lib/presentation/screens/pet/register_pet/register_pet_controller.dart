import 'dart:io';
import 'package:adopme_frontend/data/network/nestjs/analyzer_image_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:adopme_frontend/common/utils/utils.dart';

class RegisterPetController extends GetxController {
  final analyzerImageRepository = AnalyzerImageRepository();
  final utils = Utils();
  File? image;
  bool isUploading = false;
  var responseData;

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
      responseData = await analyzerImageRepository.getFeaturesPet(image!.path, base64Image);
    } catch (e) {
      responseData = null;
      print('Upload failed: $e');
    } finally {
      isUploading = false;
      update();
    }
  }
}