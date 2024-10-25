import 'package:get/get.dart';

class PetProfileController extends GetxController {
  var petName = 'Peter'.obs;
  var breed = 'Beagle'.obs;
  var gender = 'Macho'.obs;
  var weight = '10 kg'.obs;
  var description = 'Peter es un perro muy amigable que necesita mucho amor y atención. Le encanta jugar. Será un gran compañero para los niños y se llevará bien con los gatos y otros perros.'.obs;
  var imageUrl = 'https://media.ambito.com/p/7a9a5068b64700e970d5a55ecd90dfaa/adjuntos/239/imagenes/040/287/0040287673/730x0/smart/imagepng.png'.obs;

  // Función para manejar la adopción
  void adoptPet() {
    print('${petName.value} ha sido adoptado');
  }
}
