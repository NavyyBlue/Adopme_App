import 'package:adopme_frontend/models/preferences/preferences_model.dart';

class UserProfile {
  String? userId;
  PetPreferences? petPreferences;
  String? phoneNumber;
  String? studentCode;
  String? faculty;
  String? career;
  String? photoUrl;

  UserProfile({
    this.userId,
    this.petPreferences,
    this.phoneNumber,
    this.studentCode,
    this.faculty,
    this.career,
  });

  UserProfile.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] ?? '',
        petPreferences = json['pet_preferences'] != null
            ? PetPreferences.fromJson(json['pet_preferences'])
            : PetPreferences(),
        phoneNumber = json['phoneNumber'] ?? '',
        studentCode = json['studentCode'] ?? '',
        faculty = json['faculty'] ?? '',
        career = json['career'] ?? '',
        photoUrl = json['photoUrl'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    if (petPreferences != null) {
      data['pet_preferences'] = petPreferences!.toJson();
    }
    data['phoneNumber'] = phoneNumber;
    data['studentCode'] = studentCode;
    data['faculty'] = faculty;
    data['career'] = career;
    data['photoUrl'] = photoUrl;
    return data;
  }

  bool isEmpty() {
    return userId == null &&
        (petPreferences == null || petPreferences!.isEmpty()) &&
        (phoneNumber == null || phoneNumber!.isEmpty) &&
        (studentCode == null || studentCode!.isEmpty) &&
        (faculty == null || faculty!.isEmpty) &&
        (career == null || career!.isEmpty) &&
        (photoUrl == null || photoUrl!.isEmpty);
  }
}
