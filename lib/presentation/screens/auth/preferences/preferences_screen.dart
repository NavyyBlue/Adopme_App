import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adopme_frontend/presentation/widgets/buttons/preference_button.dart';
import 'package:adopme_frontend/presentation/widgets/buttons/rounded_button.dart';
import 'package:google_fonts/google_fonts.dart';
// import '../component/textfield.dart';
import '../register/register_controller.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());

    // Diccionario para almacenar el estado de cada botón
    final Map<String, bool> buttonStates = {
      'Perros': false,
      'Gatos': false,
      'Marrón': false,
      'Blanco': false,
      'Negro': false,
      'Tricolor': false,
      'Hasta 4 Kg.': false,
      '4 - 6 Kg.': false,
      '10 - 20 Kg.': false,
      '20 Kg. +': false,
    };

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
                    children: [
                      PreferenceButton(
                        text: 'Perros',
                        isSelected: buttonStates['Perros']!,
                        onPressed: (isSelected) {
                          buttonStates['Perros'] = isSelected;
                        },
                      ),
                      PreferenceButton(
                        text: 'Gatos',
                        isSelected: buttonStates['Gatos']!,
                        onPressed: (isSelected) {
                          buttonStates['Gatos'] = isSelected;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    alignment: WrapAlignment.center,
                    children: [
                      PreferenceButton(
                        text: 'Marrón',
                        isSelected: buttonStates['Marrón']!,
                        onPressed: (isSelected) {
                          buttonStates['Marrón'] = isSelected;
                        },
                      ),
                      PreferenceButton(
                        text: 'Blanco',
                        isSelected: buttonStates['Blanco']!,
                        onPressed: (isSelected) {
                          buttonStates['Blanco'] = isSelected;
                        },
                      ),
                      PreferenceButton(
                        text: 'Negro',
                        isSelected: buttonStates['Negro']!,
                        onPressed: (isSelected) {
                          buttonStates['Negro'] = isSelected;
                        },
                      ),
                      PreferenceButton(
                        text: 'Tricolor',
                        isSelected: buttonStates['Tricolor']!,
                        onPressed: (isSelected) {
                          buttonStates['Tricolor'] = isSelected;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    alignment: WrapAlignment.center,
                    children: [
                      PreferenceButton(
                        text: 'Hasta 4 Kg.',
                        isSelected: buttonStates['Hasta 4 Kg.']!,
                        onPressed: (isSelected) {
                          buttonStates['Hasta 4 Kg.'] = isSelected;
                        },
                      ),
                      PreferenceButton(
                        text: '4 - 6 Kg.',
                        isSelected: buttonStates['4 - 6 Kg.']!,
                        onPressed: (isSelected) {
                          buttonStates['4 - 6 Kg.'] = isSelected;
                        },
                      ),
                      PreferenceButton(
                        text: '10 - 20 Kg.',
                        isSelected: buttonStates['10 - 20 Kg.']!,
                        onPressed: (isSelected) {
                          buttonStates['10 - 20 Kg.'] = isSelected;
                        },
                      ),
                      PreferenceButton(
                        text: '20 Kg. +',
                        isSelected: buttonStates['20 Kg. +']!,
                        onPressed: (isSelected) {
                          buttonStates['20 Kg. +'] = isSelected;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  RoundedButton(
                    text: 'Finalizar',
                    onPressed: () {
                      print(buttonStates); // Imprime el estado de cada botón
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