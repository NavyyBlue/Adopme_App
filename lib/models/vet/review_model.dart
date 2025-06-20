import 'package:adopme_frontend/common/utils/sentiment_enum.dart';
import 'package:intl/intl.dart';

class Review {
  String? reviewId;
  double? rating;
  String? reviewTranslatedText;
  String? publishedAtDate;
  String? sentiment;

  Review(
      {this.reviewId,
        this.rating,
        this.reviewTranslatedText,
        this.publishedAtDate,
        this.sentiment});

  Review.fromJson(Map<String, dynamic> json) {
    reviewId = json['review_id'];
    rating = (json['rating'] as num?)?.toDouble();
    reviewTranslatedText = json['review_translated_text'];
    publishedAtDate = _formatDate(json['published_at_date']);
    sentiment = json['sentiment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review_id'] = reviewId;
    data['rating'] = rating;
    data['review_translated_text'] = reviewTranslatedText;
    data['published_at_date'] = publishedAtDate;
    data['sentiment'] = sentiment;
    return data;
  }

  String? _formatDate(String? date) {
    if (date == null) return null;
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd/MMM/yyyy').format(parsedDate).toUpperCase();
  }

  Sentiment getSentiment() {
    switch (sentiment) {
      case 'POSITIVE':
        return Sentiment.POSITIVE;
      case 'NEGATIVE':
        return Sentiment.NEGATIVE;
      case 'MIXED':
        return Sentiment.MIXED;
      case 'NEUTRAL':
        return Sentiment.NEUTRAL;
      default:
        return Sentiment.NEUTRAL;
    }
  }
}