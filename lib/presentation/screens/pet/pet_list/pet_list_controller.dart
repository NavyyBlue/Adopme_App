import 'package:get/get.dart';

import '../../../../data/network/nestjs/pet_repository.dart';
import '../../../../models/pet/pet_response.dart';

class PetListController extends GetxController {
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAdoptingPets();
  }

  final petRepository = PetRepository();
  var adoptingPets = <PetResponse>[].obs;

  Future<void> fetchAdoptingPets() async {
    try {
      isLoading(true);
      var pets = await petRepository.getPets(false);
      print('Pets: $pets');
      adoptingPets.assignAll(pets);
    } catch (e) {
      print('Failed to fetch adopting pets: $e');
    } finally {
      isLoading(false);
    }
  }
}
