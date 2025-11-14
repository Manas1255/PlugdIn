import 'package:plugdin/core/enums/category_type.dart';

class FeaturesResponseModel {
  const FeaturesResponseModel({
    required this.category,
    required this.features,
  });

  factory FeaturesResponseModel.fromJson(Map<String, dynamic> json) {
    final categoryValue = json['category'] as String?;
    return FeaturesResponseModel(
      category: categoryValue == null
          ? null
          : CategoryTypeExtension.toEnum(categoryValue),
      features: (json['features'] as List<dynamic>? ?? <dynamic>[])
          .map((feature) => feature as String)
          .toList(),
    );
  }

  final CategoryType? category;
  final List<String> features;

  Map<String, dynamic> toJson() {
    return {
      'category': category?.toName() ?? '',
      'features': features,
    };
  }
}
