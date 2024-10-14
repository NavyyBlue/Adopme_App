import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../widgets/textfields/textfields.dart';
import 'report_missing_pet_controller.dart';
import 'package:adopme_frontend/styles/colors.dart' as app_colors;

class ReportMissingPetScreen extends StatelessWidget {
  const ReportMissingPetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportMissingPetController>(
      init: ReportMissingPetController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Reportar mascota',
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
                        backgroundColor: app_colors
                            .Colors.backgroundButtonUploadImageMissingPetColor,
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
                    color: app_colors.Colors.primaryBackgroundReportMissingPetColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 24.0),
                    child: Column(
                      children: [
                        RegisterPetTextField(
                          controller: controller.nameController,
                          hintText: 'Nombre',
                          enabled: controller.image != null,
                          fillColor: app_colors
                              .Colors.backgroundTextFieldReportMissingPetColor,
                          textColor:
                              app_colors.Colors.textTextFieldReportMissingPetColor,
                          suffixTextColor:
                              app_colors.Colors.textTextFieldReportMissingPetColor,
                        ),
                        const SizedBox(height: 20),
                        RegisterPetTextField(
                          controller: controller.speciesController,
                          hintText: 'Especie',
                          enabled: controller.image != null,
                          fillColor: app_colors
                              .Colors.backgroundTextFieldReportMissingPetColor,
                          textColor:
                              app_colors.Colors.textTextFieldReportMissingPetColor,
                          suffixTextColor:
                              app_colors.Colors.textTextFieldReportMissingPetColor,
                        ),
                        const SizedBox(height: 20),
                        RegisterPetTextField(
                          controller: controller.breedController,
                          hintText: 'Raza',
                          enabled: controller.image != null,
                          fillColor: app_colors
                              .Colors.backgroundTextFieldReportMissingPetColor,
                          textColor:
                              app_colors.Colors.textTextFieldReportMissingPetColor,
                          suffixTextColor:
                              app_colors.Colors.textTextFieldReportMissingPetColor,
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
                                    .Colors.backgroundTextFieldReportMissingPetColor,
                                textColor: app_colors
                                    .Colors.textTextFieldReportMissingPetColor,
                                suffixTextColor: app_colors
                                    .Colors.textTextFieldReportMissingPetColor,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: RegisterPetTextField(
                                controller: controller.sizeController,
                                hintText: 'Tamaño',
                                enabled: controller.image != null,
                                fillColor: app_colors
                                    .Colors.backgroundTextFieldReportMissingPetColor,
                                textColor: app_colors
                                    .Colors.textTextFieldReportMissingPetColor,
                                suffixTextColor: app_colors
                                    .Colors.textTextFieldReportMissingPetColor,
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
                                    .Colors.backgroundTextFieldReportMissingPetColor,
                                textColor: app_colors
                                    .Colors.textTextFieldReportMissingPetColor,
                                suffixTextColor: app_colors
                                    .Colors.textTextFieldReportMissingPetColor,
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
                                    .Colors.backgroundTextFieldReportMissingPetColor,
                                textColor: app_colors
                                    .Colors.textTextFieldReportMissingPetColor,
                                suffixTextColor: app_colors
                                    .Colors.textTextFieldReportMissingPetColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        RegisterPetTextField(
                          controller: controller.descriptionController,
                          hintText: 'Descripción',
                          enabled: controller.image != null,
                          fillColor: app_colors
                              .Colors.backgroundTextFieldReportMissingPetColor,
                          textColor:
                              app_colors.Colors.textTextFieldReportMissingPetColor,
                          suffixTextColor:
                              app_colors.Colors.textTextFieldReportMissingPetColor,
                          maxLines: 4,
                        ),
                        const SizedBox(height: 20),
                        RegisterPetTextField(
                          controller: controller.locationController,
                          hintText: 'Ubicación',
                          enabled: controller.image != null,
                          fillColor: app_colors
                              .Colors.backgroundTextFieldReportMissingPetColor,
                          textColor:
                              app_colors.Colors.textTextFieldReportMissingPetColor,
                          suffixTextColor:
                              app_colors.Colors.textTextFieldReportMissingPetColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: ElevatedButton(
                      onPressed: controller.isUploading
                          ? null
                          : () async {
                              await controller.reportMissingPet(context);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: app_colors
                            .Colors.backgroundButtonReportMissingPetColor,
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
            ),
          ),
        );
      },
    );
  }
}