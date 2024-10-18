import 'package:adopme_frontend/constants/network_constants.dart';
import 'package:adopme_frontend/models/paginated_response.dart';
import 'package:adopme_frontend/models/vet/review_model.dart';
import 'package:dio/dio.dart';

class VetsReviewsRepository {
  final Dio _dio;

  VetsReviewsRepository() : _dio = Dio();

  Future<PaginatedResponse<Review>> getVetReviews({
    required String vetId,
    required int page,
    required int limit,
  }) async {
    try {
      const baseUrl = NetworkConstants.baseUrl;
      const vetRoute = NetworkConstants.reviewsRoute;
      var reviewsRoute =
          NetworkConstants.reviewsVetEndpoint.replaceAll('{vetId}', vetId);

      final response =
          await _dio.get('$baseUrl$vetRoute$reviewsRoute', queryParameters: {
        'page': page,
        'limit': limit,
      });

      return PaginatedResponse<Review>.fromJson(
        response.data as Map<String, dynamic>,
        (json) => Review.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Review> addReview({
    required String vetId,
    required int rating,
    required String reviewText,
  }) async {
    try {
      const baseUrl = NetworkConstants.baseUrl;
      const vetRoute = NetworkConstants.reviewsRoute;
      var reviewsRoute =
          NetworkConstants.reviewsVetEndpoint.replaceAll('{vetId}', vetId);

      final response = await _dio.post(
        '$baseUrl$vetRoute$reviewsRoute',
        data: {
          'rating': rating,
          'review_translated_text': reviewText,
        },
      );
      if (response.statusCode == 201 && response.data != null && response.data != '') {
        return Review.fromJson(response.data as Map<String, dynamic>);
      } else {
        return Review();
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
