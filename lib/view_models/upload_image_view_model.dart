import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/upload_response.dart';
import '../services/image_upload_service.dart';

class UploadImageViewModel extends ChangeNotifier {
  File? _image;
  bool _isUploading = false;
  UploadResponse? _responseData;
  final ImageUploadService _uploadService = ImageUploadService();

  File? get image => _image;
  bool get isUploading => _isUploading;
  UploadResponse? get responseData => _responseData;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadImage() async {
    if (_image == null) return;

    _isUploading = true;
    notifyListeners();

    try {
      _responseData = await _uploadService.uploadImage(_image!);
    } catch (e) {
      _responseData = null;
      print('Upload failed: $e');
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }
}
