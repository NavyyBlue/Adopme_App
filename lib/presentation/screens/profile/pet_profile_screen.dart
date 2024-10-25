import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pet_profile_controller.dart';

class PetProfileScreen extends StatelessWidget {
  final PetProfileController controller = Get.put(PetProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil de la Mascota"),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Imagen de la mascota
            Obx(() => ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                controller.imageUrl.value,
                height: 200,
                fit: BoxFit.cover,
              ),
            )),
            SizedBox(height: 16),

            // Nombre del perro
            Obx(() => Text(
              controller.petName.value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            )),
            SizedBox(height: 8),

            // Información básica: raza, sexo y peso
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(() => InfoBox(label: 'Raza', value: controller.breed.value)),
                Obx(() => InfoBox(label: 'Sexo', value: controller.gender.value)),
                Obx(() => InfoBox(label: 'Peso', value: controller.weight.value)),
              ],
            ),
            SizedBox(height: 16),

            // Descripción de la mascota
            Obx(() => Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                controller.description.value,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
            )),
            SizedBox(height: 16),

            // Botón de adoptar
            ElevatedButton(
              onPressed: controller.adoptPet,
              child: Text('Adoptar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800], // Cambia 'primary' a 'backgroundColor'
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// Widget para la información básica de la mascota
class InfoBox extends StatelessWidget {
  final String label;
  final String value;

  const InfoBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
