import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adopme_frontend/presentation/screens/pet/pet_list/pet_list_controller.dart';
import 'package:adopme_frontend/presentation/screens/profile/pet_profile_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PetListScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

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
          body: Column(
            children: [
              // Botón para desplegar el filtro
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton.icon(
                  onPressed: controller.toggleFilterMenu,
                  icon: Icon(Icons.filter_alt),
                  label: Text('Filtrar por imagen'),
                ),
              ),
              // Menú desplegable para cargar la imagen
              Obx(() {
                if (controller.isFilterMenuOpen.value) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          controller.analyzeImage(File(image.path));
                        }
                      },
                      icon: Icon(Icons.image),
                      label: Text('Subir imagen'),
                    ),
                  );
                }
                return SizedBox.shrink();
              }),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (controller.filteredPets.isEmpty) {
                    return Center(child: Text('No se encontraron mascotas.'));
                  } else {
                    return ListView.builder(
                      itemCount: controller.filteredPets.length,
                      itemBuilder: (context, index) {
                        var pet = controller.filteredPets[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => PetProfileScreen());
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
                                        Text(
                                          pet.name!,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
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
              ),
            ],
          ),
        );
      },
    );
  }
}