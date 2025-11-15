class FeaturesRequestModel {
  const FeaturesRequestModel({
    required this.features,
  });

  const FeaturesRequestModel.empty() : features = const [];

  final List<String> features;

  FeaturesRequestModel copyWith({
    List<String>? features,
  }) {
    return FeaturesRequestModel(
      features: features ?? this.features,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'features': features,
    };
  }
}
