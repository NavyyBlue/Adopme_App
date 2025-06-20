import 'package:get/get.dart';

import '../../../data/network/nestjs/pet_repository.dart';
import '../../../models/pet/pet_response.dart';

class PetProfileController extends GetxController {
  var petName = 'Peter'.obs;
  var breed = 'Beagle'.obs;
  var gender = 'Macho'.obs;
  var weight = '10 kg'.obs;
  var description =
      'Peter es un perro muy amigable que necesita mucho amor y atención. Le encanta jugar. Será un gran compañero para los niños y se llevará bien con los gatos y otros perros.'
          .obs;
  var imageUrl =
      'https://media.ambito.com/p/7a9a5068b64700e970d5a55ecd90dfaa/adjuntos/239/imagenes/040/287/0040287673/730x0/smart/imagepng.png'
          .obs;
  var petId = '1'.obs;

  // Función para manejar la adopción
  void adoptPet() {
    print('${petName.value} ha sido adoptado');
  }

  final PetRepository petRepository;
  var pet = PetResponse().obs;
  var isLoading = true.obs;

  PetProfileController(this.petRepository);

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
      final response = await petRepository.getPetById(id, false);
      pet.value = response;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
