import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adopme_frontend/presentation/screens/pet/pet_list/pet_list_controller.dart';
import 'package:adopme_frontend/presentation/screens/profile/pet_profile_screen.dart';

class PetListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetListController>(
      init: PetListController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('AdoptMe'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  controller.fetchAdoptingPets();
                },
              ),
            ],
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.adoptingPets.isEmpty) {
              return Center(child: Text('No pets registered.'));
            } else {
              return ListView.builder(
                itemCount: controller.adoptingPets.length,
                itemBuilder: (context, index) {
                  var pet = controller.adoptingPets[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => PetProfileScreen(), arguments: pet);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                pet.imageUrl!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        pet.name!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      // IconButton(
                                      //   icon: Icon(
                                      //     controller.favoritePets.contains(pet.petId)
                                      //         ? Icons.favorite
                                      //         : Icons.favorite_border,
                                      //     color: Colors.red,
                                      //   ),
                                      //   onPressed: () {
                                      //     controller.toggleFavorite(pet.petId as int);
                                      //   },
                                      // ),
                                    ],
                                  ),
                                  Text(
                                    pet.breed!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    'Edad: ${pet.age} meses',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.monitor_weight, size: 16, color: Colors.grey),
                                      SizedBox(width: 4),
                                      Text(
                                        '${pet.weight} kg',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
        );
      },
    );
  }
}