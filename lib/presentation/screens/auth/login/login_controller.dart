import 'package:adopme_frontend/constants/firebase_auth_error_messages.dart';
import 'package:adopme_frontend/presentation/screens/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adopme_frontend/presentation/screens/home/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static LoginController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (formKey.currentState!.validate()) {
      try {
        await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Get.offAll(() => HomeScreen());
      } on FirebaseAuthException catch (e) {
        String message = FirebaseAuthErrorMessages.getMessage(e.code);
        Get.snackbar(
          "Error",
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await auth.signInWithCredential(credential);
      Get.offAll(() => HomeScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }
  }

  void signOut() async {
    await auth.signOut();
    Get.offAll(() => LoginScreen());
  }

  bool validateEmail(String email) {
    return email.isNotEmpty && email.contains('@');
  }

  bool validatePassword(String password) {
    return password.isNotEmpty && password.length > 6;
  }
}