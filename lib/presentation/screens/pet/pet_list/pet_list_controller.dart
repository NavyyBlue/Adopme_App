import 'package:get/get.dart';

import '../../../../data/network/nestjs/pet_repository.dart';
import '../../../../models/pet/pet_response.dart';
import 'dart:io';

class PetListController extends GetxController {
  var isLoading = true.obs;
  var isFilterMenuOpen = false.obs;
  var filteredPets = <PetResponse>[].obs;

  final petRepository = PetRepository();
  var adoptingPets = <PetResponse>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAdoptingPets();
  }

  Future<void> fetchAdoptingPets() async {
    try {
      isLoading(true);
      var pets = await petRepository.getPets(false);
      adoptingPets.assignAll(pets);
      filteredPets.assignAll(pets); // Inicializa los resultados filtrados
    } catch (e) {
      print('Failed to fetch adopting pets: $e');
    } finally {
      isLoading(false);
    }
  }

  void toggleFilterMenu() {
    isFilterMenuOpen(!isFilterMenuOpen.value);
  }

  Future<void> analyzeImage(File image) async {
    try {
      isLoading(true);

      // Simula una llamada a la API para analizar la imagen
      await Future.delayed(Duration(seconds: 2));
      // Aquí podrías obtener las características de la imagen como resultado
      var characteristics = ['small', 'white'];

      // Filtra la lista de mascotas según las características
      filteredPets.assignAll(adoptingPets.where((pet) {
        return characteristics.any((c) => pet.breed!.toLowerCase().contains(c));
      }).toList());
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudo analizar la imagen.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }
}
