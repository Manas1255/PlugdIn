import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:plugdin/core/models/api_response/api_response_model.dart';
import 'package:plugdin/core/models/api_response/base_api_response.dart';

class AuthData extends Equatable {
  const AuthData({
    required this.message,
    required this.token,
    required this.isEmailVerified,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      message: json['message'] as String,
      token: json['token'] as String? ?? '',
      isEmailVerified: json['isEmailVerified'] as bool,
    );
  }

  static ResponseModel<BaseApiResponse<AuthData>> parseResponse(
    Response<dynamic> response,
  ) {
    return ResponseModel.fromApiResponse<BaseApiResponse<AuthData>>(
      response,
      (json) => BaseApiResponse<AuthData>.fromJson(
        json,
        AuthData.fromJson,
      ),
    );
  }

  final String message;
  final String token;
  final bool isEmailVerified;

  Map<String, dynamic> toJson() => {
    'message': message,
    'token': token,
    'isEmailVerified': isEmailVerified,
  };

  AuthData copyWith({
    String? message,
    String? token,
    bool? isEmailVerified,
  }) {
    return AuthData(
      message: message ?? this.message,
      token: token ?? this.token,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  @override
  List<Object?> get props => [message, token, isEmailVerified];
}
