import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  GoogleSignInButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: MaterialButton(
        height: 45,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: Colors.grey),
        ),
        onPressed: onPressed,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/google_logo.png'),
                      fit: BoxFit.contain),
                ),
              ),
            ),
            Center(
              child: Text("Inicia Sesión con Google"),
            ),
          ],
        ),
      ),
    );
  }
}