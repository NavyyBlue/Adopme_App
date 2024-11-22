import 'package:adopme_frontend/constants/firebase_constants.ts.dart';
import 'package:adopme_frontend/firebase_options.dart';
import 'package:adopme_frontend/presentation/screens/auth/login/login_controller.dart';
import 'package:adopme_frontend/services/auth_service.dart';
import 'package:adopme_frontend/services/preferences_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'data/local/database_helper.dart';
import 'data/network/nestjs/pet_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database; // Initialize the database
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  firebaseInitialization.then((value) {
    Get.put(LoginController());
    Get.put(PetRepository());
    Get.put(AuthService());
    Get.put(PreferencesService());
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      /*
      initialBinding: BindingsBuilder(() {
        Get.put(LoginController());
      }),*/
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}