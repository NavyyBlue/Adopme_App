import 'package:get/get.dart';
import '../../../../data/network/nestjs/pet_repository.dart';
import '../../../../models/pet/pet_response.dart';

class MissingPetDetailController extends GetxController {
  final PetRepository petRepository;
  var pet = PetResponse().obs;
  var isLoading = true.obs;

  MissingPetDetailController(this.petRepository);

  @override
  void onInit() {
    super.onInit();
    final PetResponse pet = Get.arguments;
    final String petId = pet.petId ?? '';
    print('Pet ID: $petId');
    if (petId.isNotEmpty) {
      fetchPetDetail(petId);
    }
  }

  void fetchPetDetail(String id) async {
  try {
    isLoading(true);
    final response = await petRepository.getPetById(id, true);
    pet.value = response;
    } catch (e) {
    Get.snackbar('Error', e.toString());
  } finally {
    isLoading(false);
  }
}
}