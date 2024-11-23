import 'package:adopme_frontend/common/utils/pet_age_enum.dart';
import 'package:adopme_frontend/common/utils/pet_color_enum.dart';
import 'package:adopme_frontend/common/utils/pet_type_enum.dart';
import 'package:adopme_frontend/presentation/screens/auth/preferences/preferences_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adopme_frontend/presentation/widgets/buttons/preference_button.dart';
import 'package:adopme_frontend/presentation/widgets/buttons/rounded_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../models/preferences/preferences_model.dart';

class PreferencesScreen extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final PreferencesController preferencesController =
      Get.put(PreferencesController());
  Set<PetType> petType = {};
  Set<PetColor> petColor = {};
  Set<PetAge> petAge = {};
  Set<PetSize> petSize = {};

  final Map<String, PetSize> petSizeIntervals = {
    'Hasta 4 Kg.': PetSize(min: 0, max: 4),
    '4 - 6 Kg.': PetSize(min: 4, max: 6),
    '10 - 20 Kg.': PetSize(min: 10, max: 20),
    '20 Kg. +': PetSize(min: 20, max: null),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'AdoptMe',
                style: GoogleFonts.caveat(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    'Preferencias',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Elige algunas etiquetas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.teal[700],
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    alignment: WrapAlignment.center,
                    children: PetType.values.map((PetType type) {
                      return FilterChip(
                        label: Text(PetType.toValueLabel(type.value)),
                        selected: petType.contains(type),
                        onSelected: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              petType.add(type);
                            } else {
                              petType.remove(type);
                            }
                          });
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.transparent)),
                        backgroundColor: Color(0xFFE3EDFB),
                        selectedColor: Color(0xFFB0D4F8),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    alignment: WrapAlignment.center,
                    children: PetColor.values.map((PetColor color) {
                      return FilterChip(
                        label: Text(PetColor.toValueLabel(color.value)),
                        selected: petColor.contains(color),
                        onSelected: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              petColor.add(color);
                            } else {
                              petColor.remove(color);
                            }
                          });
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.transparent)),
                        backgroundColor: Color(0xFFE3EDFB),
                        selectedColor: Color(0xFFB0D4F8),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    alignment: WrapAlignment.center,
                    children: petSizeIntervals.keys.map((String sizeInterval) {
                      return FilterChip(
                        label: Text(sizeInterval),
                        selected:
                            petSize.contains(petSizeIntervals[sizeInterval]),
                        onSelected: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              petSize.add(petSizeIntervals[sizeInterval]!);
                            } else {
                              petSize.remove(petSizeIntervals[sizeInterval]);
                            }
                          });
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.transparent)),
                        backgroundColor: Color(0xFFE3EDFB),
                        selectedColor: Color(0xFFB0D4F8),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    alignment: WrapAlignment.center,
                    children: PetAge.values.map((PetAge age) {
                      return FilterChip(
                        label: Text(PetAge.toValueLabel(age.value)),
                        selected: petAge.contains(age),
                        onSelected: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              petAge.add(age);
                            } else {
                              petAge.remove(age);
                            }
                          });
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.transparent)),
                        backgroundColor: Color(0xFFE3EDFB),
                        selectedColor: Color(0xFFB0D4F8),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 50),
                  RoundedButton(
                    text: 'Finalizar',
                    onPressed: () {
                      final preferences = PetPreferences(
                        petType: petType.map((type) => type.value).toList(),
                        size: petSize.toList(),
                        age: petAge.map((age) => age.value).toList(),
                        color: petColor.map((color) => color.value).toList(),
                      );
                      preferencesController.addPreferences(preferences);
                      print(preferences.toJson());
                      // aqui para registrar al user
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
