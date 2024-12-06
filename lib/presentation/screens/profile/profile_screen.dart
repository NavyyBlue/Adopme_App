import 'package:adopme_frontend/models/user/user_profile.dart';
import 'package:adopme_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adopme_frontend/presentation/screens/auth/login/login_controller.dart';
import 'package:adopme_frontend/presentation/screens/profile/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final controller = Get.find<LoginController>();
    final profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Obx(() {
        final isEditing = profileController.isEditing.value;
        final userProfileData = profileController.userProfile.value;
        final userPhotoUrl = (user!.photoURL?.isNotEmpty == true)
            ? user.photoURL
            : (userProfileData?.photoUrl?.isNotEmpty == true)
            ? userProfileData!.photoUrl
            : 'https://media.licdn.com/dms/image/v2/C4E03AQEp55lSR4WuIw/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1657679721882?e=2147483647&v=beta&t=JEDBdZmahqY1tiw1kWegxfx20OOG6QIDfUdtU3EBTiE';

        return Container(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            children: [
              if (user != null) ...[
                const SizedBox(height: 10),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        child: ClipOval(
                          child: Image.network(
                            userPhotoUrl!,
                            width: 120,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            profileController.toggleEditing();
                          },
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 20),
                Text('Teléfono'),
                const SizedBox(height: 5),
                TextField(
                  controller: profileController.phoneNumberController,
                  enabled: isEditing,
                  style: TextStyle(color: Color(0xFF000000)),
                  decoration: InputDecoration(
                    hintText: userProfileData?.phoneNumber ?? 'No disponible',
                    border: isEditing ? OutlineInputBorder() : InputBorder.none,
                  ),
                ),
                const SizedBox(height: 10),
                Text('Código de estudiante'),
                const SizedBox(height: 5),
                TextField(
                  controller: profileController.studentCodeController,
                  enabled: isEditing,
                  style: TextStyle(color: Color(0xFF000000)),
                  decoration: InputDecoration(
                    hintText: userProfileData?.studentCode ?? 'No disponible',
                    border: isEditing ? OutlineInputBorder() : InputBorder.none,
                  ),
                ),
                const SizedBox(height: 10),
                Text('Escuela'),
                const SizedBox(height: 5),
                DisabledTextField(
                  hintText: userProfileData?.career ?? 'No disponible',
                ),
                const SizedBox(height: 10),
                Text('Facultad'),
                const SizedBox(height: 5),
                DisabledTextField(
                  hintText: userProfileData?.faculty ?? 'No disponible',
                ),
                const SizedBox(height: 10),
                Text('Email'),
                const SizedBox(height: 5),
                DisabledTextField(
                  hintText: user.email ?? 'No disponible',
                ),
                const SizedBox(height: 20),
                if (isEditing) ...[
                  ElevatedButton(
                    onPressed: () {
                      profileController.saveUserProfile();
                    },
                    child: Text('Guardar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      profileController.cancelEditing();
                    },
                    child: Text('Cancelar'),
                  ),
                ] else ...[
                  ElevatedButton(
                    onPressed: () {
                      controller.signOut();
                    },
                    child: Text('Cerrar sesión'),
                  ),
                ],
              ]
            ],
          ),
        );
      }),
    );
  }
}

class DisabledTextField extends StatelessWidget {
  final String hintText;

  const DisabledTextField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: false,
      style: TextStyle(color: Color(0xFF000000)),
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
      ),
    );
  }
}
