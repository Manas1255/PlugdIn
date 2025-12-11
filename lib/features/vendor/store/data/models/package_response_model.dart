import 'package:plugdin/features/vendor/store/data/models/package_model.dart';

class PackageResponseModel {
  PackageResponseModel({
    required this.package,
  });

  factory PackageResponseModel.fromJson(Map<String, dynamic> json) {
    return PackageResponseModel(
      package: PackageModel.fromJson(
        json['package'] as Map<String, dynamic>,
      ),
    );
  }

  final PackageModel package;

  Map<String, dynamic> toJson() {
    return {
      'package': package.toJson(),
    };
  }
}
