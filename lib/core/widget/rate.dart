import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

enum RatingMode { face, star }

class Rate extends StatelessWidget {
  final double initialRating;
  final Axis direction;
  final Function(double)? onRatingUpdate;
  final RatingMode ratingMode;
  final bool draggable;
  final double itemSize;

  const Rate(
      {super.key,
      required this.initialRating,
      this.onRatingUpdate,
      this.direction = Axis.horizontal,
      this.ratingMode = RatingMode.star,
      this.draggable = false,
      this.itemSize = 10});

  Widget _ratingBar(RatingMode mode, context) {
    switch (mode) {
      case RatingMode.star:
        return RatingBar.builder(
          initialRating: initialRating,
          minRating: 1,
          maxRating: 5,
          direction: direction,
          allowHalfRating: true,
          ignoreGestures: !draggable,
          unratedColor: Theme.of(context).colorScheme.primary.withAlpha(50),
          itemCount: 5,
          itemSize: itemSize,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Theme.of(context).colorScheme.primary,
          ),
          onRatingUpdate: onRatingUpdate ?? (_) {},
          updateOnDrag: draggable,
        );

      case RatingMode.face:
        return RatingBar.builder(
          initialRating: initialRating,
          direction: direction,
          itemCount: 5,
          maxRating: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return const Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                );
              case 1:
                return const Icon(
                  Icons.sentiment_dissatisfied,
                  color: Colors.redAccent,
                );
              case 2:
                return const Icon(
                  Icons.sentiment_neutral,
                  color: Colors.amber,
                );
              case 3:
                return const Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.lightGreen,
                );
              case 4:
                return const Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                );
              default:
                return Container();
            }
          },
          onRatingUpdate: onRatingUpdate ?? (_) {},
          updateOnDrag: true,
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ratingBar(ratingMode, context);
  }
}
