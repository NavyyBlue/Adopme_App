import 'dart:ui';

import 'package:flutter/material.dart';

enum Sentiment {
  POSITIVE,
  NEGATIVE,
  MIXED,
  NEUTRAL,
}

extension SentimentExtension on Sentiment {
  Color get color {
    switch (this) {
      case Sentiment.POSITIVE:
        return Colors.green;
      case Sentiment.NEGATIVE:
        return Colors.red;
      case Sentiment.MIXED:
        return Colors.orange;
      case Sentiment.NEUTRAL:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}

extension SentimentStringExtension on Sentiment {
  String get string {
    switch (this) {
      case Sentiment.POSITIVE:
        return 'Positivo';
      case Sentiment.NEGATIVE:
        return 'Negativo';
      case Sentiment.MIXED:
        return 'Mixto';
      case Sentiment.NEUTRAL:
        return 'Neutral';
      default:
        return 'Neutral';
    }
  }
}