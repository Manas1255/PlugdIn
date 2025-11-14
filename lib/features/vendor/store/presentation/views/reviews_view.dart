import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_constants.dart';
import 'package:plugdin/features/vendor/store/presentation/widgets/reviews_widget.dart';

class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ReviewsWidget(
      reviewerName: 'reviewerName',
      reviewComment: 'reviewComment',
      reviewerProfileImage: AppConstants.appPlaceHolderSellerImage,
    );
  }
}
