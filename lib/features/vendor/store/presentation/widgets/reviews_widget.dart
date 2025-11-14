import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({
    required this.reviewerName,
    required this.reviewComment,
    required this.reviewerProfileImage,
    super.key,
  });
  final String reviewerName;
  final String reviewComment;
  final String reviewerProfileImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            PICNIWidget(
              imageUrl: reviewerProfileImage,
              height: 24,
              width: 24,
              borderRadius: BorderRadius.circular(100),
            ),
            const SizedBox(width: 10),
            Text(
              reviewerName,
              style: context.h1.copyWith(
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          reviewComment,
          style: context.l2.copyWith(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
