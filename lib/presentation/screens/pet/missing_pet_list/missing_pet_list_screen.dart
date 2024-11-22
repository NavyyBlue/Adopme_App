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
        title: Text('Mascotas Perdidas'),
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
              return Padding(
                padding: const EdgeInsets.all(8.0), // Add padding around each card
                child: InkWell(
                  onTap: () {
                    Get.to(() => MissingPetDetailScreen(), arguments: pet);
                  },
                  child: Card(
                    child: SizedBox(
                      height: 150,
                      child: Row(
                        children: [
                          pet.imageUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    pet.imageUrl!,
                                    width: 150,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(Icons.pets, size: 100),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Nombre: ${pet.name ?? 'Unknown'}', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('Raza: ${pet.breed ?? 'Unknown'}'),
                                Text('Edad: ${pet.age ?? 'Unknown'} meses'),
                                Text('Ubicación: ${pet.location ?? 'Unknown location'}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}