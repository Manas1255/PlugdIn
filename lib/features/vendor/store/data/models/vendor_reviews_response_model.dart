import 'package:plugdin/core/models/pagination_model.dart';
import 'package:plugdin/features/vendor/store/data/models/add_review_response_model.dart';

class VendorReviewsResponseModel {
  const VendorReviewsResponseModel({
    required this.reviews,
    required this.pagination,
  });

  factory VendorReviewsResponseModel.fromJson(Map<String, dynamic> json) {
    return VendorReviewsResponseModel(
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      pagination:
          PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }

  final List<ReviewModel> reviews;
  final PaginationModel pagination;

  Map<String, dynamic> toJson() {
    return {
      'reviews': reviews.map((review) => review.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }

  @override
  String toString() {
    return 'VendorReviewsResponseModel(reviews: ${reviews.length}, pagination: $pagination)';
  }
}

