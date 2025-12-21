import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_colors.dart';

class StarRatingWidget extends StatefulWidget {
  const StarRatingWidget({
    required this.onRatingChanged,
    this.initialRating = 0.0,
    this.starSize = 40.0,
    super.key,
  });

  final ValueChanged<double> onRatingChanged;
  final double initialRating;
  final double starSize;

  @override
  State<StarRatingWidget> createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  void _updateRating(double newRating) {
    setState(() {
      _rating = newRating;
    });
    widget.onRatingChanged(newRating);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final isFullStar = _rating >= starIndex;

        return GestureDetector(
          onTap: () => _updateRating(starIndex.toDouble()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Icon(
              isFullStar ? Icons.star : Icons.star_border,
              color: AppColors.yellow,
              size: widget.starSize,
            ),
          ),
        );
      }),
    );
  }
}

