import 'package:adopme_frontend/common/utils/sentiment_enum.dart';
import 'package:adopme_frontend/models/vet/review_model.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatefulWidget {
  final Review review;

  const ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  bool _isExpanded = false;
  bool _changeExpanded = false;

  @override
  Widget build(BuildContext context) {
    Sentiment sentiment = widget.review.getSentiment();
    _isExpanded = widget.review.reviewTranslatedText!.length < 100;
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
                      Row(
                        children: [
                          Text(
                            widget.review.rating.toString(),
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
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.review.reviewTranslatedText!,
                              maxLines: _isExpanded || _changeExpanded ? null : 2,
                              overflow: _isExpanded || _changeExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (!_isExpanded)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _changeExpanded = !_changeExpanded;
                                  });
                                },
                                child: Text(
                                  _changeExpanded ? 'mostrar menos' : 'mostrar más',
                                  style: TextStyle(
                                    color: Colors.blueGrey[400],
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                      Text(
                        widget.review.publishedAtDate!,
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