class AddReviewRequestModel {
  const AddReviewRequestModel({
    required this.vendorId,
    required this.packageId,
    required this.review,
    required this.rating,
  });

  final String vendorId;
  final String packageId;
  final String review;
  final double rating;

  Map<String, dynamic> toJson() {
    return {
      'vendorId': vendorId,
      'packageId': packageId,
      'review': review,
      'rating': rating,
    };
  }
}

