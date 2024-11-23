import 'package:adopme_frontend/constants/firebase_auth_error_messages.dart';
import 'package:adopme_frontend/data/network/nestjs/preferences_repository.dart';
import 'package:adopme_frontend/presentation/screens/auth/email_verification/email_verification_screen.dart';
import 'package:adopme_frontend/presentation/screens/auth/login/login_screen.dart';
import 'package:adopme_frontend/presentation/screens/auth/preferences/preferences_screen.dart';
import 'package:adopme_frontend/services/auth_service.dart';
import 'package:adopme_frontend/services/preferences_service.dart';
import 'package:adopme_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adopme_frontend/presentation/screens/home/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final PreferencesRepository preferencesRepository = PreferencesRepository();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static LoginController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  String? idToken;

  @override
  void onReady() {
    /*
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
     */
    screenRedirect();
  }

  screenRedirect() async {
    final user = auth.currentUser;
    idToken = user != null ? await auth.currentUser!.getIdToken() : null;

    if(idToken != null){
      AuthService.to.setIdToken(idToken!);
      Get.put(UserService());
    }

    if (user != null) {
      if(!user.emailVerified) {
        Get.offAll(() => EmailVerificationScreen());
      }
      else if(await PreferencesService.to.getPreferences() == null){
        _checkPreferences();
      }
      else {
        Get.offAll(() => const HomeScreen());
      }
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  Future<void> _checkPreferences() async {
    try {
      final result = await preferencesRepository.getPreferences();

      if(result!.isEmpty()){
        Get.offAll(() => PreferencesScreen());
      } else {
        PreferencesService.to.setPreferences(result);
        Get.offAll(() => HomeScreen());
      }
    } catch (e) {
      signOut();
    }
  }

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Email y contraseña no pueden estar vacíos",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
      return;
    }

    //if (formKey.currentState!.validate()) {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Clean the text fields
      emailController.clear();
      passwordController.clear();

      screenRedirect();
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
    //}
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await auth.signInWithCredential(credential);
      screenRedirect();
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
    await PreferencesService.to.clearPreferences();
    Get.offAll(() => LoginScreen());
  }

  bool validateEmail(String email) {
    return email.isNotEmpty && email.contains('@');
  }

  bool validatePassword(String password) {
    return password.isNotEmpty && password.length > 6;
  }
}
