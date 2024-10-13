import 'dart:async';

import 'package:adopme_frontend/constants/network_constants.dart';
import 'package:adopme_frontend/models/paginated_response.dart';
import 'package:adopme_frontend/models/vet/vet_model.dart';
import 'package:dio/dio.dart';

class VetRepository {
  final Dio _dio;

  VetRepository() : _dio = Dio();

  Future<PaginatedResponse<Vet>> getVets(
      {required int page, required int limit}) async {
    try {
      const baseUrl = NetworkConstants.baseUrl;
      const vetRoute = NetworkConstants.vetRoute;

      final response = await _dio.get(
        '$baseUrl$vetRoute',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      return PaginatedResponse<Vet>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => Vet.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
