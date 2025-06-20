import 'dart:async';

import 'package:adopme_frontend/constants/network_constants.dart';

import 'package:dio/dio.dart';

import '../../../models/adoptions_forms/adoptions_forms_request.dart';

class AdoptionsFormsRepository {
  final Dio dio;

  AdoptionsFormsRepository() : dio = Dio();

  Future<String> createAdoptionsForm(
      CreateAdoptionForm adoptionsFormsRequest) async {
    try {
      print('Creating adoptions form ${adoptionsFormsRequest.toJson()}');
      final response = await dio
          .post(
        '${NetworkConstants.baseUrl}${NetworkConstants.adoptionsFormsRoute}${NetworkConstants.adoptionsFormsCreateEndpoint}',
        data: adoptionsFormsRequest.toJson(),
      )
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Time out');
      });

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');
      print('Response headers: ${response.headers}');

      if (response.statusCode == 201) {
        return 'Formulario de adopción enviado';
      } else {
        throw Exception('Failed to create adoptions form');
      }

    } on DioException catch (e) {
      throw Exception(e.message);
    } on TimeoutException catch (_) {
      throw Exception('Time out');
    }
  }
}
