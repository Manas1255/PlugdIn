class AddReviewResponseModel {
  AddReviewResponseModel({
    required this.message,
    required this.review,
  });

  factory AddReviewResponseModel.fromJson(Map<String, dynamic> json) {
    return AddReviewResponseModel(
      message: json['message'] as String? ?? '',
      review: ReviewModel.fromJson(
        json['review'] as Map<String, dynamic>,
      ),
    );
  }

  final String message;
  final ReviewModel review;

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'review': review.toJson(),
    };
  }
}

class ReviewModel {
  ReviewModel({
    required this.id,
    required this.packageId,
    required this.review,
    required this.rating,
    required this.createdAt,
    required this.customer,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id']?.toString() ?? '',
      packageId: json['packageId']?.toString() ?? '',
      review: json['review']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['createdAt']?.toString() ?? '',
      customer: CustomerModel.fromJson(
        json['customer'] as Map<String, dynamic>,
      ),
    );
  }

  final String id;
  final String packageId;
  final String review;
  final double rating;
  final String createdAt;
  final CustomerModel customer;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'packageId': packageId,
      'review': review,
      'rating': rating,
      'createdAt': createdAt,
      'customer': customer.toJson(),
    };
  }
}

class CustomerModel {
  CustomerModel({
    required this.id,
    required this.name,
    required this.username,
    this.profilePicture,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      profilePicture: json['profilePicture']?.toString(),
    );
  }

  final String id;
  final String name;
  final String username;
  final String? profilePicture;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'username': username,
      'profilePicture': profilePicture,
    };
  }
}

