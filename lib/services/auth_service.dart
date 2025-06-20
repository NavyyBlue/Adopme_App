import 'package:get/get.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  String? idToken;

  void setIdToken(String token) {
    idToken = token;
  }

  String? getIdToken() {
    return idToken;
  }
}