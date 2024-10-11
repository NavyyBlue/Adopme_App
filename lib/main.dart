import 'package:adopme_frontend/presentation/screens/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'views/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AdoptMe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
