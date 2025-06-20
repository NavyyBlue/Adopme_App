import 'dart:async';

import 'package:adopme_frontend/constants/network_constants.dart';
import 'package:adopme_frontend/models/analyzer_image/get_features_pet/get_features_pet_response.dart';
import 'package:dio/dio.dart';

class AnalyzerImageRepository {
  final Dio dio;

  AnalyzerImageRepository() : dio = Dio();

  Future<GetFeaturesPetResponse> getFeaturesPet(
      String filename, String file) async {
    try {
      final response = await dio.post(
          '${NetworkConstants.baseUrl}${NetworkConstants
              .analyzerImageRoute}${NetworkConstants.getFeaturesPetEndpoint}',
          data: {
            'filename': filename,
            'file': file,
          }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Time out');
      });

      return GetFeaturesPetResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.message);
    } on TimeoutException catch (_) {
      throw Exception('Time out');
    }
  }
}
