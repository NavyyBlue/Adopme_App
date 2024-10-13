import 'dart:convert';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils{

  Future<String> convertImageToBytes(File image) async {
    final bytes = await image.readAsBytes();
    img.Image? originalImage = img.decodeImage(bytes);

    int quality = 95;
    List<int> compressedBytes = img.encodeJpg(originalImage!, quality: quality);

    while (compressedBytes.length > 3 * 1024 * 1024 && quality > 10) {
      quality -= 5;
      compressedBytes = img.encodeJpg(originalImage, quality: quality);
    }

    final base64Image = base64Encode(compressedBytes);
    return base64Image;
  }

  Future<String> generateImageName(File image) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String? serialNumber = androidInfo.id;

    String formattedDate = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

    String imageFormat = image.path.split('.').last;

    String imageName = '${serialNumber}_$formattedDate.$imageFormat';

    return imageName;
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
  }
}