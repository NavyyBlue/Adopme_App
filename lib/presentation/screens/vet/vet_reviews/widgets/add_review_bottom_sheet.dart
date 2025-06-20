import 'package:adopme_frontend/presentation/screens/vet/vet_reviews/vet_reviews_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adopme_frontend/styles/colors.dart' as colors;

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

  void _submitReview() {
    _controller.addReview(
      vetId: widget.vetId,
      rating: _rating,
      reviewText: _commentController.text
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colors.Colors.bakcgroundColorButton),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colors.Colors.bakcgroundColorButton),
                ),
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
              onPressed: _rating == 0 ? null : _submitReview,
              style: ElevatedButton.styleFrom(backgroundColor: colors.Colors.bakcgroundColorButton),
              child: const Text(
                'Agregar Review',
                style: TextStyle(color: colors.Colors.textButtonColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}