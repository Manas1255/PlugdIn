import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:plugdin/core/models/api_response/api_response_model.dart';
import 'package:plugdin/core/models/api_response/base_api_response.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.isPremium,
    required this.isAdmin,
    required this.reminders,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.resetPasswordCode,
    this.resetPasswordCodeExpires,
    this.imageUrl,
    this.profilePhoto,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userData = json['user'] as Map<String, dynamic>? ?? json;

    return UserModel(
      id: userData['id']?.toString() ?? '',
      email: userData['email']?.toString() ?? '',
      name: userData['name']?.toString() ?? '',
      isPremium: userData['isPremium'] == true,
      isAdmin: userData['isAdmin'] == true,
      reminders: userData['reminders'] as List<dynamic>? ?? [],
      createdAt: userData['createdAt']?.toString() ?? '',
      updatedAt: userData['updatedAt']?.toString() ?? '',
      version: userData['__v'] as int? ?? 0,
      resetPasswordCode: userData['resetPasswordCode']?.toString(),
      resetPasswordCodeExpires: userData['resetPasswordCodeExpires']
          ?.toString(),
      imageUrl: userData['imageUrl']?.toString(),
      profilePhoto: userData['profilePhoto']?.toString(),
    );
  }

  static ResponseModel<BaseApiResponse<UserModel>> parseResponse(
    Response<dynamic> response,
  ) {
    return ResponseModel.fromApiResponse<BaseApiResponse<UserModel>>(
      response,
      (json) => BaseApiResponse<UserModel>.fromJson(
        json,
        UserModel.fromJson,
      ),
    );
  }

  final String id;
  final String email;
  final String name;
  final bool isPremium;
  final bool isAdmin;
  final List<dynamic> reminders;
  final String createdAt;
  final String updatedAt;
  final int version;
  final String? resetPasswordCode;
  final String? resetPasswordCodeExpires;
  final String? imageUrl;
  final String? profilePhoto;

  Map<String, dynamic> toJson() => {
    '_id': id,
    'email': email,
    'name': name,
    'isPremium': isPremium,
    'isAdmin': isAdmin,
    'reminders': reminders,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': version,
    'resetPasswordCode': resetPasswordCode,
    'resetPasswordCodeExpires': resetPasswordCodeExpires,
    'imageUrl': imageUrl,
    'profilePhoto': profilePhoto,
  };

  @override
  List<Object?> get props => [
    id,
    email,
    name,
    isPremium,
    isAdmin,
    reminders,
    createdAt,
    updatedAt,
    version,
    resetPasswordCode,
    resetPasswordCodeExpires,
    imageUrl,
    profilePhoto,
  ];
}
