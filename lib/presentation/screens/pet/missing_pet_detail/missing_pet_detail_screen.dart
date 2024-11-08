import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/pet/pet_response.dart';
import 'missing_pet_detail_controller.dart';

class MissingPetDetailScreen extends StatelessWidget {
  final MissingPetDetailController controller = Get.put(MissingPetDetailController(Get.find()));

  @override
  Widget build(BuildContext context) {
    final PetResponse pet = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Details'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (pet.imageUrl != null)
                    Image.network(pet.imageUrl!),
                  SizedBox(height: 16),
                  Text('Name: ${pet.name}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Weight: ${pet.weight}'),
                  SizedBox(height: 8),
                  Text('Size: ${pet.size}'),
                  SizedBox(height: 8),
                  Text('Species: ${pet.species}'),
                  SizedBox(height: 8),
                  Text('Breed: ${pet.breed}'),
                  SizedBox(height: 8),
                  Text('Age: ${pet.age}'),
                  SizedBox(height: 8),
                  Text('Gender: ${pet.gender}'),
                  SizedBox(height: 8),
                  Text('Location: ${pet.location}'),
                  SizedBox(height: 8),
                  Text('Description: ${pet.description}'),
                  SizedBox(height: 8),
                  Text('Color: ${pet.color}'),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}