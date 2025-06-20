import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adopme_frontend/presentation/screens/pet/register_pet/register_pet_controller.dart';
import 'package:adopme_frontend/styles/colors.dart' as app_colors;
import '../../../widgets/textfields/textfields.dart';

class RegisterPetScreen extends StatelessWidget {
  const RegisterPetScreen({super.key});

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
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.mail_outline, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Registrar mascotas',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
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
                      if (context.mounted) {
                        await controller.uploadImage(context);
                      }
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: Text('Subir imagen'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        app_colors.Colors.backgroundButtonUploadImagePetColor,
                    foregroundColor: app_colors.Colors.textButtonColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: app_colors.Colors.primaryBackgroundRegisterPetColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 24.0),
                child: Column(
                  children: [
                    RegisterPetTextField(
                      controller: controller.nameController,
                      hintText: 'Nombre',
                      enabled: controller.image != null,
                      fillColor:
                          app_colors.Colors.backgroundTextFieldRegisterPetColor,
                      textColor:
                          app_colors.Colors.textTextFieldRegisterPetColor,
                      suffixTextColor:
                          app_colors.Colors.textTextFieldRegisterPetColor,
                    ),
                    const SizedBox(height: 20),
                    RegisterPetTextField(
                      controller: controller.speciesController,
                      hintText: 'Especie',
                      enabled: controller.image != null,
                      fillColor:
                          app_colors.Colors.backgroundTextFieldRegisterPetColor,
                      textColor:
                          app_colors.Colors.textTextFieldRegisterPetColor,
                      suffixTextColor:
                          app_colors.Colors.textTextFieldRegisterPetColor,
                    ),
                    const SizedBox(height: 20),
                    RegisterPetTextField(
                      controller: controller.breedController,
                      hintText: 'Raza',
                      enabled: controller.image != null,
                      fillColor:
                          app_colors.Colors.backgroundTextFieldRegisterPetColor,
                      textColor:
                          app_colors.Colors.textTextFieldRegisterPetColor,
                      suffixTextColor:
                          app_colors.Colors.textTextFieldRegisterPetColor,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: RegisterPetTextField(
                            controller: controller.weightController,
                            hintText: 'Peso',
                            suffixText: 'kg',
                            enabled: controller.image != null,
                            keyboardType: TextInputType.number,
                            fillColor: app_colors
                                .Colors.backgroundTextFieldRegisterPetColor,
                            textColor:
                                app_colors.Colors.textTextFieldRegisterPetColor,
                            suffixTextColor:
                                app_colors.Colors.textTextFieldRegisterPetColor,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: RegisterPetTextField(
                            controller: controller.sizeController,
                            hintText: 'Tamaño',
                            enabled: controller.image != null,
                            fillColor: app_colors
                                .Colors.backgroundTextFieldRegisterPetColor,
                            textColor:
                                app_colors.Colors.textTextFieldRegisterPetColor,
                            suffixTextColor:
                                app_colors.Colors.textTextFieldRegisterPetColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: RegisterPetTextField(
                            controller: controller.ageController,
                            hintText: 'Edad',
                            suffixText: 'meses',
                            enabled: controller.image != null,
                            keyboardType: TextInputType.number,
                            fillColor: app_colors
                                .Colors.backgroundTextFieldRegisterPetColor,
                            textColor:
                                app_colors.Colors.textTextFieldRegisterPetColor,
                            suffixTextColor:
                                app_colors.Colors.textTextFieldRegisterPetColor,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 2,
                          child: RegisterPetTextField(
                            controller: controller.colorController,
                            hintText: 'Color',
                            enabled: controller.image != null,
                            fillColor: app_colors
                                .Colors.backgroundTextFieldRegisterPetColor,
                            textColor:
                                app_colors.Colors.textTextFieldRegisterPetColor,
                            suffixTextColor:
                                app_colors.Colors.textTextFieldRegisterPetColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: null,
                      hint: Text('Sexo'),
                      items: ['Macho', 'Hembra']
                          .map((sexo) => DropdownMenuItem(
                        value: sexo,
                        child: Text(sexo),
                      ))
                          .toList(),
                      onChanged: (value) {
                        controller.genderController.text = value ?? '';
                      },
                      decoration: InputDecoration(
                        fillColor: app_colors
                            .Colors.backgroundTextFieldRegisterPetColor,
                        filled: true,
                        hintText: 'Sexo',
                        hintStyle: TextStyle(
                          color: app_colors.Colors.textTextFieldRegisterPetColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: controller.isUploading
                      ? null
                      : () async {
                          await controller.registerPet(context);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        app_colors.Colors.backgroundButtonRegisterPetColor,
                    foregroundColor: app_colors.Colors.textButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: controller.isUploading
                      ? const CircularProgressIndicator()
                      : Text('Registrar mascota'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
