import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:plugdin/core/models/api_response/api_response_model.dart';
import 'package:plugdin/core/models/api_response/base_api_response.dart';

part 'vendor_model.g.dart';

@HiveType(typeId: 3)
class VendorModel extends Equatable {
  const VendorModel({
    required this.name,
    required this.username,
    required this.email,
    required this.companyName,
    required this.companyLogo,
    required this.personName,
    required this.address,
    required this.city,
    required this.phoneNumber,
    required this.primaryCategory,
    required this.additionalCategories,
    required this.businessDescription,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    final vendorData = json['vendor'] as Map<String, dynamic>? ?? json;

    return VendorModel(
      name: vendorData['name']?.toString() ?? '',
      username: vendorData['username']?.toString() ?? '',
      email: vendorData['email']?.toString() ?? '',
      companyName: vendorData['companyName']?.toString() ?? '',
      companyLogo: vendorData['companyLogo']?.toString() ?? '',
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
      businessDescription: vendorData['businessDescription']?.toString() ?? '',
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
  final String name;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String companyName;
  @HiveField(4)
  final String companyLogo;
  @HiveField(5)
  final String personName;
  @HiveField(6)
  final String address;
  @HiveField(7)
  final String city;
  @HiveField(8)
  final String phoneNumber;
  @HiveField(9)
  final String primaryCategory;
  @HiveField(10)
  final List<String> additionalCategories;
  @HiveField(11)
  final String businessDescription;

  Map<String, dynamic> toJson() => {
    'name': name,
    'username': username,
    'email': email,
    'companyName': companyName,
    'companyLogo': companyLogo,
    'personName': personName,
    'address': address,
    'city': city,
    'phoneNumber': phoneNumber,
    'primaryCategory': primaryCategory,
    'additionalCategories': additionalCategories,
    'businessDescription': businessDescription,
  };

  @override
  List<Object?> get props => [
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
    businessDescription,
  ];
}
