import 'package:adopme_frontend/common/utils/utils.dart';
import 'package:adopme_frontend/models/vet/vet_model.dart';
import 'package:adopme_frontend/presentation/screens/vet/vet_reviews/widgets/add_review_bottom_sheet.dart';
import 'package:adopme_frontend/presentation/screens/vet/vet_reviews/widgets/review_card.dart';
import 'package:adopme_frontend/presentation/screens/vet/vet_reviews/widgets/vet_review_card.dart';
import 'package:adopme_frontend/presentation/screens/vet/vet_reviews/widgets/vet_review_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adopme_frontend/presentation/screens/vet/vet_reviews/vet_reviews_controller.dart';
import 'package:adopme_frontend/models/vet/review_model.dart';

class VetReviewsScreen extends StatelessWidget {
  final Vet vet;
  final VetReviewsController controller = Get.put(VetReviewsController());

  VetReviewsScreen({super.key, required this.vet});

  @override
  Widget build(BuildContext context) {
    final utils = Utils();
    utils.requestLocationPermission();
    controller.fetchReviews(vetId: vet.placeId!, page: 1, limit: 10);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reviews',
          style: TextStyle(
            color: Color(0xFF2E4E7C),
            fontWeight: FontWeight.w900,
            fontSize: 25.0,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 35.0,
              color: Color(0xFF2E4E7C),
            ),
            onPressed: () {
              _showAddReviewBottomSheet(context);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchReviews(vetId: vet.placeId!, page: 1, limit: 10);
        },
        child: Column(
          children: [
            Container(
              height: 200.0, // Ajusta la altura según sea necesario
              child: VetReviewMap(vet: vet),
            ),
            VetReviewCard(vet: vet),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                child: Obx(() {
                  if (controller.isLoading.value &&
                      controller.paginatedReviews.value.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.paginatedReviews.value.data == null ||
                      controller.paginatedReviews.value.data!.isEmpty) {
                    return const Center(
                        child: Text('No hay reviews disponibles.'));
                  }

                  return NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                          !controller.isLoading.value) {
                        controller.loadNextPage(vet.placeId!);
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: controller.paginatedReviews.value.data!.length,
                      itemBuilder: (context, index) {
                        Review review =
                        controller.paginatedReviews.value.data![index];
                        return ReviewCard(review: review);
                      },
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddReviewBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddReviewBottomSheet(vetId: vet.placeId!);
      },
    );
  }
}