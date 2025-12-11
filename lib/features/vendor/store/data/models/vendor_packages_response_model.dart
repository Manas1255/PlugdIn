import 'package:plugdin/core/models/pagination_model.dart';
import 'package:plugdin/features/vendor/store/data/models/package_model.dart';

class VendorPackagesResponseModel {
  const VendorPackagesResponseModel({
    required this.packages,
    this.pagination,
  });

  factory VendorPackagesResponseModel.fromJson(Map<String, dynamic> json) {
    final packagesJson = json['packages'] as List<dynamic>? ?? <dynamic>[];

    return VendorPackagesResponseModel(
      packages: packagesJson
          .map((package) => PackageModel.fromJson(package as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : PaginationModel.fromJson(
              json['pagination'] as Map<String, dynamic>,
            ),
    );
  }

  final List<PackageModel> packages;
  final PaginationModel? pagination;

  Map<String, dynamic> toJson() {
    return {
      'packages': packages.map((package) => package.toJson()).toList(),
      if (pagination != null) 'pagination': pagination?.toJson(),
    };
  }
}
