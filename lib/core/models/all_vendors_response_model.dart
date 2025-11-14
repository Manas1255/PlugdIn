import 'package:plugdin/core/enums/role_type.dart';

class AllVendorsResponseModel {
  const AllVendorsResponseModel({
    required this.vendors,
  });
  factory AllVendorsResponseModel.fromJson(Map<String, dynamic> json) {
    final vendorsJson = json['vendors'] as List<dynamic>? ?? <dynamic>[];

    return AllVendorsResponseModel(
      vendors: vendorsJson
          .map((vendor) => Vendor.fromJson(vendor as Map<String, dynamic>))
          .toList(),
    );
  }

  final List<Vendor> vendors;

  Map<String, dynamic> toJson() {
    return {
      'vendors': vendors.map((vendor) => vendor.toJson()).toList(),
    };
  }
}

class Vendor {
  const Vendor({
    required this.id,
    required this.userId,
    required this.companyName,
    required this.companyLogo,
    required this.personName,
    required this.address,
    required this.city,
    required this.phoneNumber,
    required this.primaryCategory,
    required this.additionalCategories,
    required this.features,
    required this.links,
    required this.status,
    required this.businessDescription,
    required this.isVerified,
    required this.approvedAt,
    required this.media,
  });
  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['_id'] as String?,
      userId: json['userId'] == null
          ? null
          : UserId.fromJson(json['userId'] as Map<String, dynamic>),
      companyName: json['companyName'] as String?,
      companyLogo: json['companyLogo'] as String?,
      personName: json['personName'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      primaryCategory: json['primaryCategory'] as String?,
      additionalCategories:
          (json['additionalCategories'] as List<dynamic>?)
              ?.map((item) => item as String)
              .toList() ??
          <String>[],
      features: json['features'] as List<dynamic>?,
      links:
          (json['links'] as List<dynamic>?)
              ?.map((item) => item as String)
              .toList() ??
          <String>[],
      status: json['status'] as String?,
      businessDescription: json['businessDescription'] as String?,
      isVerified: json['isVerified'] as bool?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.tryParse(json['approvedAt'] as String),
      media: (json['media'] as List<dynamic>?) ?? <dynamic>[],
    );
  }

  final String? id;
  final UserId? userId;
  final String? companyName;
  final String? companyLogo;
  final String? personName;
  final String? address;
  final String? city;
  final String? phoneNumber;
  final String? primaryCategory;
  final List<String> additionalCategories;
  final List<dynamic>? features;
  final List<String> links;
  final String? status;
  final String? businessDescription;
  final bool? isVerified;
  final DateTime? approvedAt;
  final List<dynamic> media;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId?.toJson(),
      'companyName': companyName,
      'companyLogo': companyLogo,
      'personName': personName,
      'address': address,
      'city': city,
      'phoneNumber': phoneNumber,
      'primaryCategory': primaryCategory,
      'additionalCategories': additionalCategories,
      'features': features,
      'links': links,
      'status': status,
      'businessDescription': businessDescription,
      'isVerified': isVerified,
      'approvedAt': approvedAt?.toIso8601String(),
      'media': media,
    };
  }
}

class UserId {
  const UserId({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.role,
    required this.createdAt,
  });
  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      role: (json['role'] as String?) == null
          ? null
          : RoleType.toEnum(json['role'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.tryParse(json['createdAt'] as String),
    );
  }

  final String? id;
  final String? name;
  final String? username;
  final String? email;
  final RoleType? role;
  final DateTime? createdAt;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'username': username,
      'email': email,
      'role': role?.toName,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
