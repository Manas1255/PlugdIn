class VendorFeaturesResponseModel {
  VendorFeaturesResponseModel({
    required this.message,
    required this.vendor,
  });

  factory VendorFeaturesResponseModel.fromJson(Map<String, dynamic> json) {
    return VendorFeaturesResponseModel(
      message: json['message'] as String,
      vendor: VendorFeaturesModel.fromJson(
        json['vendor'] as Map<String, dynamic>,
      ),
    );
  }

  final String message;
  final VendorFeaturesModel vendor;

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'vendor': vendor.toJson(),
    };
  }
}

class VendorFeaturesModel {
  VendorFeaturesModel({
    required this.features,
  });

  factory VendorFeaturesModel.fromJson(Map<String, dynamic> json) {
    return VendorFeaturesModel(
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  final List<String> features;

  Map<String, dynamic> toJson() {
    return {
      'features': features,
    };
  }
}

