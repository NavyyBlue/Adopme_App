import 'dart:async';

import 'package:adopme_frontend/constants/network_constants.dart';
import 'package:adopme_frontend/data/dio_client.dart';
import 'package:adopme_frontend/models/user/create_user_profile_payload.dart';
import 'package:adopme_frontend/models/user/user_profile.dart';
import 'package:dio/dio.dart';

class UserProfileRepository {
  final Dio _dio = DioClient().dio;
  final baseUrl = NetworkConstants.baseUrl;
  final preferencesRoute = NetworkConstants.userRoute;

  UserProfileRepository();

  Future<void> createUserProfile(CreateUserProfile payload) async {
    try {
      final response = await _dio.post('$baseUrl$preferencesRoute', data: payload.toJson());

      if (response.statusCode != 201) {
        throw Exception('Failed to create user profile');
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } on TimeoutException catch (_) {
      throw Exception('Time out');
    }
  }

  Future<void> updateUserProfile(UserProfile payload) async {
    try {
      final response = await _dio.put('$baseUrl$preferencesRoute', data: payload.toJson());

      if (response.statusCode != 200) {
        throw Exception('Failed to update user profile');
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } on TimeoutException catch (_) {
      throw Exception('Time out');
    }
  }

  Future<UserProfile> getUserProfile() async {
    try {
      final response = await _dio.get('$baseUrl$preferencesRoute');

      if (response.data == null || response.data == '') {
        return UserProfile();
      }
      final userProfile = UserProfile.fromJson(response.data);

      return userProfile;
    } on DioException catch (e) {
      throw Exception(e.message);
    } on TimeoutException catch (_) {
      throw Exception('Time out');
    }
  }

  Future<void> verifyEmail(String email) async {
      await _dio.post('$baseUrl$preferencesRoute/verify-email', data: {'email': email});
  }

  Future<UserProfile> getUserById(String userId) async {
    try {
      final response = await _dio.get('$baseUrl$preferencesRoute/$userId');


      if (response.data == null || response.data == '') {
        return UserProfile();
      }
      final userProfile = UserProfile.fromJson(response.data);

      return userProfile;
    } on DioException catch (e) {
      throw Exception(e.message);
    } on TimeoutException catch (_) {
      throw Exception('Time out');
    }
  }
}