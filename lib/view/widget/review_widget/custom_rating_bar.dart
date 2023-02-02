import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatelessWidget {
  bool enableRating;
  double? ratingValue;
  double size;
  int starCount;
  Function(double)? onRatingUpdated;
  CustomRatingBar(
      {this.ratingValue,
      this.enableRating = false,
      this.size = 50,
      this.starCount = 5,
      this.onRatingUpdated});

  @override
  Widget build(BuildContext context) {
    if (enableRating) {
      return RatingBar.builder(
          itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
          itemCount: starCount,
          itemSize: size,
          onRatingUpdate: (value) {
            onRatingUpdated?.call(value);
          });
    } else {
      return RatingBarIndicator(
        itemBuilder: (context, index) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        rating: ratingValue ?? 5.0,
        itemCount: starCount,
        itemSize: size,
      );
    }
  }
}
