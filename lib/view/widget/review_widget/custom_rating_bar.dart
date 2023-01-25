import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatelessWidget {
  bool enableRating;
  int? ratingValue;
  double size;
  int starCount;
  Function? onRatingUpdated;
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
        onRatingUpdate: onRatingUpdated?.call(),
      );
    } else {
      return RatingBarIndicator(
        itemBuilder: (context, index) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        rating: 5,
        itemCount: 1,
        itemSize: size,
      );
    }
  }
}
