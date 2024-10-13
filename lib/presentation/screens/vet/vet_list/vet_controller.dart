import 'package:adopme_frontend/data/network/nestjs/vets_repository.dart';
import 'package:adopme_frontend/models/paginated_response.dart';
import 'package:adopme_frontend/models/vet/vet_model.dart';
import 'package:get/get.dart';

class VetController extends GetxController {
  final vetRepository = VetRepository();
  var paginatedVets = PaginatedResponse<Vet>().obs;
  var isLoading = false.obs;
  var currentPage = 1;
  var limit = 10;

  @override
  void onInit() {
    super.onInit();
    fetchVets(page: 1, limit: 10);
  }

  Future<void> fetchVets({required int page, required int limit}) async {
    try {
      isLoading.value = true;
      final response = await vetRepository.getVets(page: page, limit: limit);
      if (page == 1) {
        paginatedVets.value = response;
      } else {
        paginatedVets.update((val) {
          val?.data?.addAll(response.data!);
          val?.nextPageUrl = response.nextPageUrl;
          val?.prevPageUrl = response.prevPageUrl;
          val?.count = response.count;
          val?.totalPages = response.totalPages;
        });
      }
    } catch (e) {
      // Handle error
      print('Error fetching vets: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void loadNextPage() {
    if (paginatedVets.value.nextPageUrl != null && !isLoading.value) {
      currentPage++;
      fetchVets(page: currentPage, limit: limit);
    }
  }

}