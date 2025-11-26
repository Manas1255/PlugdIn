import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:plugdin/core/api_service/app_api_exception.dart';
import 'package:plugdin/core/api_service/authentication_interceptor.dart';
import 'package:plugdin/core/api_service/log_interceptor.dart';
import 'package:plugdin/core/app_preferences/app_preferences.dart';
import 'package:plugdin/core/di/injector.dart';
import 'package:plugdin/core/endpoints/endpoints.dart';
import 'package:plugdin/core/models/api_response/base_api_response.dart';

class ApiService {
  factory ApiService() => _instance;

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: '${Endpoints.baseUrl}/',
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(AuthInterceptor(_appPreferences, _dio));
    _dio.interceptors.add(LoggingInterceptor());
  }

  static final ApiService _instance = ApiService._internal();

  late final Dio _dio;
  final AppPreferences _appPreferences = Injector.resolve<AppPreferences>();

  /// GET Request
  Future<Response<dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    return _handleRequest(
      () => _dio.get(endpoint, queryParameters: queryParams),
    );
  }

  /// POST Request
  Future<Response<dynamic>> post({
    required String endpoint,
    dynamic data,
  }) async {
    return _handleRequest(() => _dio.post(endpoint, data: data));
  }

  /// PUT Request
  Future<Response<dynamic>> put(String endpoint, dynamic data) async {
    return _handleRequest(() => _dio.put(endpoint, data: data));
  }

  /// PATCH Request
  Future<Response<dynamic>> patch(String endpoint, dynamic data) async {
    return _handleRequest(() => _dio.patch(endpoint, data: data));
  }

  /// POST Multipart Request
  Future<Response<dynamic>> postMultipart(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final formData = FormData.fromMap(data);
    return _handleRequest(() => _dio.post(endpoint, data: formData));
  }

  /// PUT Multipart Request
  Future<Response<dynamic>> putMultipart(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final formData = FormData.fromMap(data);
    return _handleRequest(() => _dio.put(endpoint, data: formData));
  }

  /// DELETE Request
  Future<Response<dynamic>> delete(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    return _handleRequest(
      () => _dio.delete(endpoint, queryParameters: queryParams),
    );
  }

  /// Handles Requests & Centralized Error Handling
  Future<Response<dynamic>> _handleRequest(
    Future<Response<dynamic>> Function() request,
  ) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      debugPrint('Unhandled error: $e');
      throw AppApiException('Unexpected error occurred');
    }
  }

  AppApiException _handleDioError(DioException e) {
    var errorMessage = 'An unknown error occurred';
    int? statusCode;

    if (e.response != null) {
      statusCode = e.response?.statusCode;
      final dynamic responseData = e.response?.data;

      if (responseData is Map<String, dynamic>) {
        try {
          final baseResponse = BaseApiResponse.fromJson(
            responseData,
            (json) => null,
          );

          if (baseResponse.errorMessage != null &&
              baseResponse.errorMessage!.isNotEmpty) {
            errorMessage = baseResponse.errorMessage!;
          } else if (baseResponse.error != null &&
              baseResponse.error!.message.isNotEmpty) {
            errorMessage = baseResponse.error!.message;
          } else {
            switch (statusCode) {
              case 400:
                errorMessage = 'Bad request';
              case 401:
                errorMessage = 'Unauthorized';
              case 403:
                errorMessage = 'Forbidden';
              case 404:
                errorMessage = 'Not found';
              case 409:
                errorMessage = 'Resource already exists';
              case 500:
                errorMessage = 'Internal server error';
              default:
                errorMessage =
                    'Unexpected error: ${e.response?.statusMessage ?? 'Unknown status'}';
            }
          }
        } catch (parseError) {
          debugPrint(
            'Failed to parse error response with BaseApiResponse: $parseError',
          );
          switch (statusCode) {
            case 400:
              errorMessage = 'Bad request';
            case 401:
              errorMessage = 'Unauthorized';
            case 403:
              errorMessage = 'Forbidden';
            case 404:
              errorMessage = 'Not found';
            case 409:
              errorMessage = 'Resource already exists';
            case 500:
              errorMessage = 'Internal server error';
            default:
              errorMessage =
                  'Unexpected error: ${e.response?.statusMessage ?? 'Unknown status'}';
          }
        }
      } else {
        errorMessage = responseData.toString();
      }
    } else {
      errorMessage = e.message ?? 'Network error';
    }

    debugPrint('❌ API Error: $errorMessage (Status: $statusCode)');
    throw AppApiException(errorMessage, statusCode: statusCode);
  }
}
