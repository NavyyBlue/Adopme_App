import 'package:adopme_frontend/presentation/screens/vet/vet_reviews/vet_reviews_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddReviewBottomSheet extends StatefulWidget {
  final String vetId;

  const AddReviewBottomSheet({super.key, required this.vetId});

  @override
  _AddReviewBottomSheetState createState() => _AddReviewBottomSheetState();
}

class _AddReviewBottomSheetState extends State<AddReviewBottomSheet> {
  final TextEditingController _commentController = TextEditingController();
  final VetReviewsController _controller = Get.find<VetReviewsController>();
  int _rating = 0;

  void _setRating(int rating) {
    setState(() {
      _rating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    late final vetId = widget.vetId;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                labelText: 'Comentario',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: index < _rating ? Colors.yellow : Colors.grey,
                  ),
                  onPressed: () => _setRating(index + 1),
                  iconSize: 32.0,
                );
              }),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _controller.addReview(
                  vetId: vetId,
                  rating: _rating,
                  reviewText: _commentController.text,
                );
                Navigator.of(context).pop();
              },
              child: const Text('Agregar Review'),
            ),
          ],
        ),
      ),
    );
  }
}