import 'package:plugdin/core/models/api_response/api_error.dart';

class BaseApiResponse<T> {
  BaseApiResponse({
    required this.statusCode,
    this.error,
    this.errorMessage,
    this.data,
  });
  factory BaseApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) parser,
  ) {
    final statusCode = json['statusCode'] as int;
    ApiError? parsedError;
    String? directErrorMessage;

    final dynamic errorValue = json['error'];

    if (errorValue != null) {
      if (errorValue is String) {
        directErrorMessage = errorValue;
      } else if (errorValue is Map<String, dynamic>) {
        parsedError = ApiError.fromJson(errorValue);
      }
    }

    T? parsedData;
    if (json['data'] != null && errorValue == null) {
      parsedData = parser(json['data'] as Map<String, dynamic>);
    }

    return BaseApiResponse<T>(
      statusCode: statusCode,
      error: parsedError,
      errorMessage: directErrorMessage,
      data: parsedData,
    );
  }

  final int statusCode;
  final ApiError? error;
  final String? errorMessage;
  final T? data;

  bool get hasError => error != null;
}
