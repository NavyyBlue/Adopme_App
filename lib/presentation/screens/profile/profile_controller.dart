import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:adopme_frontend/models/user/user_profile.dart';
import 'package:adopme_frontend/services/user_service.dart';

class ProfileController extends GetxController {
  final UserService userService = UserService.to;
  final RxBool isEditing = false.obs;
  final Rx<UserProfile?> userProfile = Rx<UserProfile?>(null);

  final TextEditingController studentCodeController = TextEditingController();
  final TextEditingController careerController = TextEditingController();
  final TextEditingController facultyController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    userProfile.value = await userService.userProfileRepository.getUserProfile();
    if (userProfile.value != null) {
      studentCodeController.text = userProfile.value!.studentCode ?? '';
      careerController.text = userProfile.value!.career ?? '';
      facultyController.text = userProfile.value!.faculty ?? '';
      phoneNumberController.text = userProfile.value!.phoneNumber ?? '';
    }
  }

  void toggleEditing() {
    isEditing.value = !isEditing.value;
  }

  void cancelEditing() {
    isEditing.value = false;
    loadUserProfile();
  }

  Future<void> saveUserProfile() async {
    if (userProfile.value != null) {
      userProfile.value!.studentCode = studentCodeController.text;
      userProfile.value!.career = careerController.text;
      userProfile.value!.faculty = facultyController.text;
      userProfile.value!.phoneNumber = phoneNumberController.text;

      await userService.userProfileRepository.updateUserProfile(userProfile.value!);
      isEditing.value = false;
      loadUserProfile();
    }
  }
}