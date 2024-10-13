import 'package:adopme_frontend/common/utils/sentiment_enum.dart';
import 'package:adopme_frontend/models/vet/review_model.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({Key? key, required this.review});

  @override
  Widget build(BuildContext context) {
    Sentiment sentiment = review.getSentiment();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0x42D9D9D9),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Calificación (Rating)
                      Row(
                        children: [
                          Text(
                            review.rating.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 2.0),
                          Icon(
                            Icons.star,
                            color: Colors.yellow[700],
                            size: 15.0,
                          ),
                        ],
                      ),
                      const SizedBox(
                          width:
                              16.0), // Espacio entre la calificación y el texto
                      // Texto principal (Review)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.reviewTranslatedText!,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Fecha
                      Text(
                        review.publishedAtDate!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: Tooltip(
              message: sentiment.string,
              child: Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(
                  color: sentiment.color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
