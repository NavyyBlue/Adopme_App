import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

import '../models/upload_image_request.dart';
import '../models/upload_response.dart';

class ImageUploadService {
  final String url = 'http://192.168.1.11:3000/r2/upload';

  Future<UploadResponse> uploadImage(File image) async {
    final bytes = await image.readAsBytes();

    img.Image? originalImage = img.decodeImage(bytes);
    img.Image resizedImage = img.copyResize(originalImage!, width: 800);
    final compressedBytes = img.encodeJpg(resizedImage, quality: 85);
    final base64Image = base64Encode(compressedBytes);

    final request = UploadImageRequest(
      filename: image.path.split('/').last,
      file: base64Image,
    );

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 201) {
      return UploadResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to upload image');
    }
  }
}
