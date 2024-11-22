import 'package:adopme_frontend/data/network/nestjs/user_profile_repository.dart';
import 'package:adopme_frontend/models/user/user_profile.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  static UserService get to => Get.find();
  final userProfileRepository = UserProfileRepository();
  final Rx<UserProfile?> _userProfile = Rx<UserProfile?>(null);

  UserProfile? get userProfile => _userProfile.value;

  @override
  void onInit() {
    super.onInit();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    _userProfile.value = await userProfileRepository.getUserProfile();
  }
}
