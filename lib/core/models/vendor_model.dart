import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:plugdin/core/models/api_response/api_response_model.dart';
import 'package:plugdin/core/models/api_response/base_api_response.dart';

part 'vendor_model.g.dart';

@HiveType(typeId: 3)
class VendorModel extends Equatable {
  const VendorModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.companyName,
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
    required this.reviews,
    required this.ratings,
    required this.pricePerPerson,
    required this.capacity,
    required this.createdAt,
    required this.updatedAt,
    required this.media,
    this.companyLogo,
    this.approvedAt,
    this.rejectedAt,
    this.rejectionReason,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    final vendorData = json['vendor'] as Map<String, dynamic>? ?? json;
    final userId = vendorData['userId'] as Map<String, dynamic>?;

    return VendorModel(
      id: vendorData['_id']?.toString() ?? '',
      name: userId?['name']?.toString() ?? '',
      username: userId?['username']?.toString() ?? '',
      email: userId?['email']?.toString() ?? '',
      companyName: vendorData['companyName']?.toString() ?? '',
      companyLogo: vendorData['companyLogo']?.toString(),
      personName: vendorData['personName']?.toString() ?? '',
      address: vendorData['address']?.toString() ?? '',
      city: vendorData['city']?.toString() ?? '',
      phoneNumber: vendorData['phoneNumber']?.toString() ?? '',
      primaryCategory: vendorData['primaryCategory']?.toString() ?? '',
      additionalCategories:
          (vendorData['additionalCategories'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      features:
          (vendorData['features'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      links:
          (vendorData['links'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      status: vendorData['status']?.toString() ?? '',
      businessDescription: vendorData['businessDescription']?.toString() ?? '',
      isVerified: vendorData['isVerified'] as bool? ?? false,
      reviews: vendorData['reviews'] as int? ?? 0,
      ratings: (vendorData['ratings'] as num?)?.toDouble() ?? 0.0,
      pricePerPerson: (vendorData['pricePerPerson'] as num?)?.toDouble() ?? 0.0,
      capacity: vendorData['capacity'] as int? ?? 0,
      createdAt: vendorData['createdAt']?.toString() ?? '',
      updatedAt: vendorData['updatedAt']?.toString() ?? '',
      approvedAt: vendorData['approvedAt']?.toString(),
      rejectedAt: vendorData['rejectedAt']?.toString(),
      rejectionReason: vendorData['rejectionReason']?.toString(),
      media:
          (vendorData['media'] as List<dynamic>?)
              ?.map((e) => VendorMedia.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  static ResponseModel<BaseApiResponse<VendorModel>> parseResponse(
    Response<dynamic> response,
  ) {
    return ResponseModel.fromApiResponse<BaseApiResponse<VendorModel>>(
      response,
      (json) => BaseApiResponse<VendorModel>.fromJson(
        json,
        VendorModel.fromJson,
      ),
    );
  }

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String companyName;
  @HiveField(5)
  final String? companyLogo;
  @HiveField(6)
  final String personName;
  @HiveField(7)
  final String address;
  @HiveField(8)
  final String city;
  @HiveField(9)
  final String phoneNumber;
  @HiveField(10)
  final String primaryCategory;
  @HiveField(11)
  final List<String> additionalCategories;
  @HiveField(12)
  final List<String> features;
  @HiveField(13)
  final List<String> links;
  @HiveField(14)
  final String status;
  @HiveField(15)
  final String businessDescription;
  @HiveField(16)
  final bool isVerified;
  @HiveField(17)
  final int reviews;
  @HiveField(18)
  final double ratings;
  @HiveField(19)
  final double pricePerPerson;
  @HiveField(20)
  final int capacity;
  @HiveField(21)
  final String createdAt;
  @HiveField(22)
  final String updatedAt;
  @HiveField(23)
  final String? approvedAt;
  @HiveField(24)
  final String? rejectedAt;
  @HiveField(25)
  final String? rejectionReason;
  @HiveField(26)
  final List<VendorMedia> media;

  Map<String, dynamic> toJson() => {
    '_id': id,
    'userId': {
      'name': name,
      'username': username,
      'email': email,
    },
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
    'reviews': reviews,
    'ratings': ratings,
    'pricePerPerson': pricePerPerson,
    'capacity': capacity,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'approvedAt': approvedAt,
    'rejectedAt': rejectedAt,
    'rejectionReason': rejectionReason,
    'media': media.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [
    id,
    name,
    username,
    email,
    companyName,
    companyLogo,
    personName,
    address,
    city,
    phoneNumber,
    primaryCategory,
    additionalCategories,
    features,
    links,
    status,
    businessDescription,
    isVerified,
    reviews,
    ratings,
    pricePerPerson,
    capacity,
    createdAt,
    updatedAt,
    approvedAt,
    rejectedAt,
    rejectionReason,
    media,
  ];
}

// Media model for vendor media items
@HiveType(typeId: 4)
class VendorMedia extends Equatable {
  const VendorMedia({
    required this.type,
    required this.fileUrl,
  });

  factory VendorMedia.fromJson(Map<String, dynamic> json) {
    return VendorMedia(
      type: json['type']?.toString() ?? '',
      fileUrl: json['fileUrl']?.toString() ?? '',
    );
  }

  @HiveField(0)
  final String type;
  @HiveField(1)
  final String fileUrl;

  Map<String, dynamic> toJson() => {
    'type': type,
    'fileUrl': fileUrl,
  };

  @override
  List<Object?> get props => [type, fileUrl];
}
