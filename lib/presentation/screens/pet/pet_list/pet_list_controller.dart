import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adopme_frontend/data/local/database_helper.dart';

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
      var petList = await DatabaseHelper().getPets();
      if (petList != null) {
        pets.assignAll(petList);
      }
    } finally {
      isLoading(false);
    }
  }
}