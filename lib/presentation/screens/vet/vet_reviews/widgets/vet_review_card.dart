import 'package:adopme_frontend/models/vet/vet_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VetReviewCard extends StatelessWidget {
  final Vet vet;

  const VetReviewCard({Key? key, required this.vet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              vet.name!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF588D94),
              ),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 2.0),
                Text(
                  '${vet.reviews.toString()} calificaciones',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 5.0),
                const Icon(
                  Icons.remove,
                  color: Colors.green,
                  size: 14.0,
                ),
                const SizedBox(width: 5.0),
                Text(
                  vet.rating.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 2.0),
                Icon(
                  Icons.star,
                  color: Colors.yellow[700],
                  size: 14.0,
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                              size: 12.0,
                            ),
                          ),
                          TextSpan(
                            text: ' ${vet.address!}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
