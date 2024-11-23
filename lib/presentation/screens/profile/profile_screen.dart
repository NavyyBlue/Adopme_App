import 'package:adopme_frontend/models/user/user_profile.dart';
import 'package:adopme_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adopme_frontend/presentation/screens/auth/login/login_controller.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final UserService userService = UserService.to;
    final controller = Get.find<LoginController>();

    final UserProfile? userProfileData = userService.userProfile;

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 35),

          children: [
            if (user != null) ...[

              const SizedBox(height: 10),

              // Imagen del perfil
              Center(
                child: Stack(
                  children: [
                    Container(
                      child: ClipOval(
                        // child: Image.network('src'),
                        child: Image.network(
                          user.photoURL ??
                          'https://media.licdn.com/dms/image/v2/C4E03AQEp55lSR4WuIw/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1657679721882?e=2147483647&v=beta&t=JEDBdZmahqY1tiw1kWegxfx20OOG6QIDfUdtU3EBTiE',
                          width: 120,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFFE7E7),
                        ),
                        child: Icon(
                          Icons.edit, 
                          color: Color(0xFF762B2B),
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Nombre de usuario
              Center(
                child: Text(
                  user.displayName ?? 'No disponible',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF762B2B),
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Código de estudiante
              const SizedBox(height: 20),
              Text('Código de estudiante'),
              const SizedBox(height: 5),
              DisabledTextField(
                hintText: userProfileData?.studentCode ?? 'No disponible',
              ),

              // Escuela
              const SizedBox(height: 10),
              Text('Escuela'),
              const SizedBox(height: 5),
              DisabledTextField(
                hintText: userProfileData?.career ?? 'No disponible',
              ),

              // Facultad
              const SizedBox(height: 10),
              Text('Facultad'),
              const SizedBox(height: 5),
              DisabledTextField(
                hintText: userProfileData?.faculty ?? 'No disponible',
              ),

              // Text Phone Number
              const SizedBox(height: 10),
              Text('Phone Number'),
              const SizedBox(height: 5),
              // TextField de Phone Number
              DisabledTextField(
                hintText: userProfileData?.phoneNumber ?? 'No disponible',
              ),

              // Text Email
              const SizedBox(height: 10),
              Text('Email'),
              const SizedBox(height: 5),
              // TextField de Email
              DisabledTextField(
                hintText: user.email ?? 'No disponible',
              ),

              // Cerrar sesión
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.signOut();
                },
                child: Text('Cerrar sesión'),
              ),

            ]
          ],

        ),
      ),
    );

    /*
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user != null) ...[
              Text(
                'Nombre: ${user.displayName ?? 'No disponible'}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                'Email: ${user.email ?? 'No disponible'}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.signOut();
                  Get.offAll(() => LoginScreen());
                },
                child: Text('Cerrar sesión'),
              ),
            ] else ...[
              Text(
                'No hay usuario logeado',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ],
        ),
      ),
    );
    */
    
  }
}

class DisabledTextField extends StatelessWidget{
  final String hintText;

  const DisabledTextField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color(0xFFA1A1A1),
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFC8C8C8)),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      ),
    );
  }
}