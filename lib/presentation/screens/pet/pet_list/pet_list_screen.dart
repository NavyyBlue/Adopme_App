import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adopme_frontend/presentation/screens/pet/pet_list/pet_list_controller.dart';

class PetListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetListController>(
      init: PetListController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Registered Pets'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.pets.isEmpty) {
              return Center(child: Text('No pets registered.'));
            } else {
              return ListView.builder(
                itemCount: controller.pets.length,
                itemBuilder: (context, index) {
                  var pet = controller.pets[index];
                  return Padding(
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
                              pet['imageUrl'],
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
                                      pet['name'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        // Acción para añadir a favoritos
                                      },
                                    ),
                                  ],
                                ),
                                Text(
                                  pet['breed'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  '${pet['age']} meses',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
