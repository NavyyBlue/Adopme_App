import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../adoption_confirmation/adoption_confirmation_screen.dart';
import 'adoption_form_controller.dart';

class AdoptionFormScreen extends StatelessWidget {
  final AdoptionFormController controller = Get.put(AdoptionFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de adopción'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(controller.nameController, 'Nombre'),
            const SizedBox(height: 12),
            _buildTextField(controller.lastNameController, 'Apellido'),
            const SizedBox(height: 12),
            _buildTextField(controller.emailController, 'Correo Electrónico'),
            const SizedBox(height: 12),
            _buildTextField(controller.phoneController, 'Teléfono'),
            const SizedBox(height: 12),
            _buildTextField(controller.addressController, 'Dirección'),
            const SizedBox(height: 12),
            _buildTextField(controller.dniController, 'DNI'),
            const SizedBox(height: 24),
            Row(
              children: [
                Obx(() => Checkbox(
                  value: controller.acceptTerms.value,
                  onChanged: (value) {
                    controller.toggleAcceptTerms(value ?? false);
                  },
                )),
                const Text('Acepto los términos y condiciones.'),
              ],
            ),
            const Spacer(),
            Obx(() => ElevatedButton(
              onPressed: controller.acceptTerms.value ? () {
                controller.submitForm();
                Get.to(() => AdoptionConfirmationScreen());
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF002D63),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Continuar'),
            )),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
        currentIndex: 4,
        onTap: (index) {},
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}