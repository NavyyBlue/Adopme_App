import 'dart:async';

import 'package:adopme_frontend/constants/network_constants.dart';

import 'package:dio/dio.dart';

import '../../../models/pet/create_pet.dart';
import '../../../models/pet/pet_response.dart';

class PetRepository {
  final Dio dio;

  PetRepository() : dio = Dio();

  Future<void> createPet(CreatePet createPet, bool isMissing) async {
    try {
      final response = await dio
          .post(
        '${NetworkConstants.baseUrl}${NetworkConstants.petRoute}${NetworkConstants.petCreateEndpoint}?isMissing=$isMissing',
        data: createPet.toJson(),
      )
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Time out');
      });

      if (response.statusCode != 201) {
        throw Exception('Failed to create pet');
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } on TimeoutException catch (_) {
      throw Exception('Time out');
    }
  }

  Future<List<PetResponse>> getPets(bool isMissing) async {
    try {
      final response = await dio.get(
        '${NetworkConstants.baseUrl}${NetworkConstants.petRoute}${NetworkConstants.petGetAllEndpoint}',
        queryParameters: {'isMissing': isMissing},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Time out');
      });

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((pet) => PetResponse.fromJson(pet)).toList();
      } else {
        throw Exception('Failed to load pets');
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } on TimeoutException catch (_) {
      throw Exception('Time out');
    }
  }

  Future<PetResponse> getPetById(String id, bool isMissing) async {
    try {
      final response = await dio.get(
        '${NetworkConstants.baseUrl}${NetworkConstants.petRoute}/$id',
        queryParameters: {'isMissing': isMissing},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Time out');
      });

      if (response.statusCode == 200) {
        return PetResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load pet');
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } on TimeoutException catch (_) {
      throw Exception('Time out');
    }
  }


  Future<Map<String, dynamic>> comparePets(String filename, String file, String imageUrl) async {
    try {
      print("PetRepository comparePets");
      final response = await dio.post(
        '${NetworkConstants.baseUrl}${NetworkConstants.analyzerImageRoute}${NetworkConstants.comparePetsEndpoint}',
        data: {
          'filename': filename,
          'file': file,
          'imageUrl': imageUrl,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException('Time out');
      });
      print("Response comparePets");
      print(response.data);
      print(response);
      if (response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to compare pets');
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } on TimeoutException catch (_) {
      throw Exception('Time out');
    }
  }
}
