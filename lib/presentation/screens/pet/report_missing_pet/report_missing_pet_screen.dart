import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'report_missing_pet_controller.dart';

class ReportMissingPetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportMissingPetController(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Report Missing Pet'),
        ),
        body: Consumer<ReportMissingPetController>(
          builder: (context, controller, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: controller.nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: controller.speciesController,
                    decoration: InputDecoration(labelText: 'Species'),
                  ),
                  TextField(
                    controller: controller.breedController,
                    decoration: InputDecoration(labelText: 'Breed'),
                  ),
                  TextField(
                    controller: controller.weightController,
                    decoration: InputDecoration(labelText: 'Weight'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: controller.sizeController,
                    decoration: InputDecoration(labelText: 'Size'),
                  ),
                  TextField(
                    controller: controller.ageController,
                    decoration: InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: controller.colorController,
                    decoration: InputDecoration(labelText: 'Color'),
                  ),
                  TextField(
                    controller: controller.descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: controller.locationController,
                    decoration: InputDecoration(labelText: 'Location'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      await controller.pickImage();
                    },
                    child: Text('Pick Image'),
                  ),
                  if (controller.image != null)
                    Image.file(controller.image!),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      await controller.uploadImage();
                    },
                    child: controller.isUploading
                        ? CircularProgressIndicator()
                        : Text('Upload Image'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      await controller.reportMissingPet(context);
                    },
                    child: Text('Report Missing Pet'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}