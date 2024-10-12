import 'package:adopme_frontend/data/local/database_helper.dart';
import 'package:adopme_frontend/data/local/pets_database_helper.dart';
import 'package:get/get.dart';

class PetListController extends GetxController {
  var pets = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPets();
  }

  Future<void> fetchPets() async {
    try {
      isLoading(true);
      var petList =
          await PetsDatabaseHelper.getPets(await DatabaseHelper().database);
      pets.assignAll(petList);
    } finally {
      isLoading(false);
    }
  }
}
