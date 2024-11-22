import 'package:adopme_frontend/presentation/screens/auth/email_verification/email_verification_screen.dart';
import 'package:adopme_frontend/presentation/screens/auth/login/login_controller.dart';
import 'package:adopme_frontend/presentation/screens/auth/login/login_screen.dart';
import 'package:adopme_frontend/presentation/screens/auth/preferences/preferences_screen.dart';
import 'package:adopme_frontend/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/home', page: () => HomeScreen(), middlewares: [AuthMiddleware()]),
    GetPage(name: '/email-verification', page: () => EmailVerificationScreen(), middlewares: [AuthMiddleware()]),
    GetPage(name: '/preferences', page: () => PreferencesScreen(), middlewares: [AuthMiddleware()]),
  ];
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (Get.find<LoginController>().auth.currentUser == null) {
      return RouteSettings(name: '/login');
    }
    return null;
  }
}