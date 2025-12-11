import 'package:plugdin/core/models/all_vendors_response_model.dart';
import 'package:plugdin/core/models/pagination_model.dart';

class FilteredVendorsResponseModel {
  const FilteredVendorsResponseModel({
    required this.vendors,
    this.pagination,
  });

  factory FilteredVendorsResponseModel.fromJson(Map<String, dynamic> json) {
    final vendorsJson = json['vendors'] as List<dynamic>? ?? <dynamic>[];

    return FilteredVendorsResponseModel(
      vendors: vendorsJson
          .map((vendor) => Vendor.fromJson(vendor as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : PaginationModel.fromJson(
              json['pagination'] as Map<String, dynamic>,
            ),
    );
  }

  final List<Vendor> vendors;
  final PaginationModel? pagination;

  Map<String, dynamic> toJson() {
    return {
      'vendors': vendors.map((vendor) => vendor.toJson()).toList(),
      if (pagination != null) 'pagination': pagination?.toJson(),
    };
  }
}


