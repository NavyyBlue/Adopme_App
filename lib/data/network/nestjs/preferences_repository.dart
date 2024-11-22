import 'dart:async';

import 'package:adopme_frontend/constants/network_constants.dart';
import 'package:adopme_frontend/data/dio_client.dart';
import 'package:adopme_frontend/models/preferences/preferences_model.dart';
import 'package:adopme_frontend/services/preferences_service.dart';
import 'package:dio/dio.dart';

class PreferencesRepository {
  final Dio _dio = DioClient().dio;
  final baseUrl = NetworkConstants.baseUrl;
  final preferencesRoute = NetworkConstants.preferencesRoute;

  PreferencesRepository();

  Future<PetPreferences?> getPreferences() async {
    try {
      final response = await _dio.get('$baseUrl$preferencesRoute');

      if (response.data == null || response.data == '') {
        return PetPreferences();
      }

      final preferences = PetPreferences.fromJson(response.data);

      // Save preferences in local database
      PreferencesService.to.setPreferences(preferences);

      return preferences;
    } on DioException catch (e) {
      throw Exception(e.message);
    } on TimeoutException catch (_) {
      throw Exception('Time out');
    }
  }

  Future<void> updatePreferences(PetPreferences request) async {
    try {
      final response =
          await _dio.put('$baseUrl$preferencesRoute', data: request.toJson());
      final preferences = PetPreferences.fromJson(response.data);

      // Save preferences in local database
      PreferencesService.to.setPreferences(preferences);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on TimeoutException catch (_) {
      throw Exception('Time out');
    }
  }

  Future<void> createPreferences(PetPreferences request) async {
    try {
      final response =
          await _dio.post('$baseUrl$preferencesRoute', data: request.toJson());
      final preferences = PetPreferences.fromJson(response.data);

      // Save preferences in local database
      PreferencesService.to.setPreferences(preferences);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on TimeoutException catch (_) {
      throw Exception('Time out');
    }
  }
}
