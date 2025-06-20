import 'package:adopme_frontend/presentation/screens/vet/vet_reviews/vet_reviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adopme_frontend/models/vet/vet_model.dart';

class VetCard extends StatelessWidget {
  final Vet vet;

  const VetCard({Key? key, required this.vet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(() => VetReviewsScreen(vet: vet));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Sección de la izquierda (Texto y dirección)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vet.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Color(0xFF588D94),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '${vet.reviews} calificaciones',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16.0,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Text(
                              vet.address!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Sección de la derecha (Rating)
                Row(
                  children: [
                    Text(
                      vet.rating.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Icon(
                      Icons.star,
                      color: Colors.yellow[700],
                      size: 18.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}