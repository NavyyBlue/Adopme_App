import 'package:get/get.dart';
import '../../../../data/network/nestjs/pet_repository.dart';
import '../../../../models/pet/pet_response.dart';

class MissingPetListController extends GetxController {
  final petRepository = PetRepository();
  var missingPets = <PetResponse>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMissingPets();
  }

  Future<void> fetchMissingPets() async {
    try {
      isLoading(true);
      var pets = await petRepository.getPets(true);
      missingPets.assignAll(pets);
    } catch (e) {
      // Handle error
      print('Failed to fetch missing pets: $e');
    } finally {
      isLoading(false);
    }
  }
}