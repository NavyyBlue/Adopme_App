import 'package:adopme_frontend/presentation/screens/vet/vet_list/widgets/vet_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adopme_frontend/presentation/screens/vet/vet_list/vet_controller.dart';
import 'package:adopme_frontend/models/vet/vet_model.dart';

class VetScreen extends StatelessWidget {
  final VetController controller = Get.put(VetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Veterinarias',
          style: TextStyle(
            color: Color(0xFF2E4E7C),
            fontWeight: FontWeight.w900,
            fontSize: 25.0,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchVets(page: 1, limit: 10);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Obx(() {
            if (controller.isLoading.value &&
                controller.paginatedVets.value.data == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.paginatedVets.value.data == null ||
                controller.paginatedVets.value.data!.isEmpty) {
              return const Center(child: Text('No hay veterinarias disponibles.'));
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                    !controller.isLoading.value) {
                  controller.loadNextPage();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: controller.paginatedVets.value.data!.length,
                itemBuilder: (context, index) {
                  Vet vet = controller.paginatedVets.value.data![index];
                  return VetCard(vet: vet);
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}