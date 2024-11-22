import 'package:adopme_frontend/models/preferences/preferences_model.dart';

class UserProfile {
  String? userId;
  PetPreferences? petPreferences;
  String? phoneNumber;

  UserProfile({
    this.userId,
    this.petPreferences,
    this.phoneNumber,
  });

  UserProfile.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        petPreferences = json['petPreferences'] != null
            ? PetPreferences.fromJson(json['petPreferences'])
            : null,
        phoneNumber = json['phoneNumber'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    if (petPreferences != null) {
      data['petPreferences'] = petPreferences!.toJson();
    }
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
