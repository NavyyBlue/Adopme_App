import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/pet/pet_response.dart';
import '../missing_pet_detail/missing_pet_detail_screen.dart';
import 'missing_pet_list_controller.dart';

class MissingPetListScreen extends StatelessWidget {
  final MissingPetListController controller = Get.put(MissingPetListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Missing Pets'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.missingPets.isEmpty) {
          return Center(child: Text('No missing pets found.'));
        } else {
          return ListView.builder(
            itemCount: controller.missingPets.length,
            itemBuilder: (context, index) {
              PetResponse pet = controller.missingPets[index];
              return Card(
                child: ListTile(
                  title: Text(pet.name ?? 'Unknown'),
                  subtitle: Text(pet.description ?? 'No description'),
                  trailing: Text(pet.location ?? 'Unknown location'),
                  onTap: () {
                    Get.to(() => MissingPetDetailScreen(), arguments: pet);
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}