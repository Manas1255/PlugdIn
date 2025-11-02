import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:plugdin/core/models/api_response/api_response_model.dart';
import 'package:plugdin/core/models/api_response/base_api_response.dart';
import 'package:plugdin/enums/role_type.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.username,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final userData = json['user'] as Map<String, dynamic>? ?? json;

    return UserModel(
      id: userData['id']?.toString() ?? '',
      email: userData['email']?.toString() ?? '',
      name: userData['name']?.toString() ?? '',
      username: userData['username']?.toString() ?? '',
      role: userData['role'] != null
          ? RoleType.toEnum(userData['role'].toString())
          : RoleType.none,
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

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String username;
  @HiveField(4)
  final RoleType role;

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'username': username,
    'role': role.toName,
  };

  @override
  List<Object?> get props => [
    id,
    email,
    name,
    username,
    role,
  ];
}
