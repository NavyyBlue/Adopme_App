import 'package:adopme_frontend/data/network/nestjs/vets_reviews_repository.dart';
import 'package:adopme_frontend/models/paginated_response.dart';
import 'package:adopme_frontend/models/vet/review_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VetReviewsController extends GetxController {
  final reviewRepository = VetsReviewsRepository();
  var paginatedReviews = PaginatedResponse<Review>().obs;
  var isLoading = false.obs;
  var currentPage = 1;
  var limit = 10;

  Future<void> fetchReviews(
      {required String vetId, required int page, required int limit}) async {
    try {
      isLoading.value = true;
      final response = await reviewRepository.getVetReviews(
          vetId: vetId, page: page, limit: limit);
      if (page == 1) {
        paginatedReviews.value = response;
      } else {
        paginatedReviews.update((val) {
          val?.data?.addAll(response.data!);
          val?.nextPageUrl = response.nextPageUrl;
          val?.prevPageUrl = response.prevPageUrl;
          val?.count = response.count;
          val?.totalPages = response.totalPages;
        });
      }
    } catch (e) {
      // Handle error
      print('Error fetching reviews: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addReview(
      {required String vetId,
      required int rating,
      required String reviewText}) async {
    try {
      isLoading.value = true;
      await reviewRepository.addReview(
          vetId: vetId, rating: rating, reviewText: reviewText);
      fetchReviews(vetId: vetId, page: 1, limit: limit);
      Get.snackbar(
        'Éxito',
        'Review añadida correctamente',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      // Handle error
      print('Error adding review: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void loadNextPage(String vetId) {
    if (paginatedReviews.value.nextPageUrl != null && !isLoading.value) {
      currentPage++;
      fetchReviews(vetId: vetId, page: currentPage, limit: limit);
    }
  }
}
