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
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.mail_outline, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Registrar mascotas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await controller.pickImage();
                    if (controller.image != null) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Row(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(width: 20),
                                Text('Subiendo imagen...'),
                              ],
                            ),
                          );
                        },
                      );
                      await controller.uploadImage();
                      Navigator.of(context).pop(); // Close the dialog
                    }
                  },
                  child: Text('Subir imagen'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                    foregroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.blue[50],
                  ),
                  enabled: controller.image != null,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: TextEditingController(text: controller.responseData?.species ?? ''),
                  decoration: InputDecoration(
                    labelText: 'Especie',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.blue[50],
                  ),
                  enabled: controller.image != null,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: TextEditingController(text: controller.responseData?.breed ?? ''),
                  decoration: InputDecoration(
                    labelText: 'Raza',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.blue[50],
                  ),
                  enabled: controller.image != null,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: TextEditingController(text: controller.responseData?.weight?.toString() ?? ''),
                        decoration: InputDecoration(
                          labelText: 'Peso',
                          suffixText: 'kg',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.blue[50],
                        ),
                        enabled: controller.image != null,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: TextEditingController(text: controller.responseData?.size ?? ''),
                        decoration: InputDecoration(
                          labelText: 'Tamaño',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.blue[50],
                        ),
                        enabled: controller.image != null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: TextEditingController(text: controller.responseData?.age?.toString() ?? ''),
                        decoration: InputDecoration(
                          labelText: 'Edad',
                          suffixText: 'meses',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.blue[50],
                        ),
                        enabled: controller.image != null,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: TextEditingController(text: controller.responseData?.color ?? ''),
                        decoration: InputDecoration(
                          labelText: 'Color',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.blue[50],
                        ),
                        enabled: controller.image != null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.isUploading ? null : () async {
                    await controller.uploadImage();
                  },
                  child: controller.isUploading
                      ? CircularProgressIndicator()
                      : Text('Registrar mascota'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF153D8A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}