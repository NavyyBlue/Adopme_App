import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adopme_frontend/presentation/screens/pet/register_pet/register_pet_controller.dart';

class RegisterPetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPetController>(
      init: RegisterPetController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Registrar Mascota'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.mail_outline),
                onPressed: () {},
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    // Implementa la lógica para seleccionar una imagen
                    // y llama a controller.getFeaturesPet con los parámetros adecuados
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.blue[100],
                    child: controller.image == null
                        ? Center(child: Text('No image selected.'))
                        : Image.file(controller.image!, fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.isUploading ? null : () async {
                    // Implementa la lógica para subir la imagen
                  },
                  child: controller.isUploading
                      ? CircularProgressIndicator()
                      : Text('Subir imagen'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF153D8A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                if (controller.responseData != null) ...[
                  const SizedBox(height: 20),
                  Text('Status: ${controller.responseData!.status}'),
                  Text('Especie: ${controller.responseData!.data['Especie']}'),
                  Text('Raza: ${controller.responseData!.data['Raza']}'),
                  Text('Edad: ${controller.responseData!.data['Edad aproximada']}'),
                  Text('Peso: ${controller.responseData!.data['Peso']}'),
                  Text('Color: ${controller.responseData!.data['Color']}'),
                  Text('Tamaño: ${controller.responseData!.data['Tamaño']}'),
                  Text('Image URL: ${controller.responseData!.imageUrl}'),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}