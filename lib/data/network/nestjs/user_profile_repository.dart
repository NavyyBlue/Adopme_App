import 'dart:async';

import 'package:adopme_frontend/constants/network_constants.dart';
import 'package:adopme_frontend/data/dio_client.dart';
import 'package:adopme_frontend/models/user/create_user_profile_payload.dart';
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
}