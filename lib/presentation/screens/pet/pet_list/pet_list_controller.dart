import 'package:get/get.dart';

class PetListController extends GetxController {
  var pets = [].obs;
  var isLoading = true.obs;
  var favoritePets = <int>{}.obs; // Set para manejar mascotas favoritas por su ID.

  @override
  void onInit() {
    super.onInit();
    fetchPets(); // Llamar a la función para cargar las mascotas.
  }

  // Simulamos los datos de las mascotas.
  Future<void> fetchPets() async {
    try {
      isLoading(true);

      // Lista simulada de mascotas
      var petList = [
        {
          'id': 1,
          'name': 'Peter',
          'breed': 'Beagle Dog',
          'age': '1.5 years old',
          'distance': '2.5km',
          'imageUrl': 'https://media.ambito.com/p/7a9a5068b64700e970d5a55ecd90dfaa/adjuntos/239/imagenes/040/287/0040287673/730x0/smart/imagepng.png', // Imagen de Peter.
        },
        {
          'id': 2,
          'name': 'Carla',
          'breed': 'Pomeranian Dog',
          'age': '1 years old',
          'distance': '4.5km',
          'imageUrl': 'https://media.ambito.com/p/7a9a5068b64700e970d5a55ecd90dfaa/adjuntos/239/imagenes/040/287/0040287673/730x0/smart/imagepng.png', // Imagen de Carla.
        },
      ];

      pets.assignAll(petList);
    } finally {
      isLoading(false); // Indicamos que la carga ha terminado.
    }
  }

  // Alternar mascotas favoritas
  void toggleFavorite(int petId) {
    if (favoritePets.contains(petId)) {
      favoritePets.remove(petId);
    } else {
      favoritePets.add(petId);
    }
  }
}
