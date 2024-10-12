import 'dart:convert';
import 'dart:io';
import 'package:image/image.dart' as img;

class Utils{

  Future<String> convertImageToBytes(File image) async {
    final bytes = await image.readAsBytes();
    img.Image? originalImage = img.decodeImage(bytes);
    img.Image resizedImage = img.copyResize(originalImage!, width: 800);
    final compressedBytes = img.encodeJpg(resizedImage, quality: 85);
    final base64Image = base64Encode(compressedBytes);
    return base64Image;
  }
}