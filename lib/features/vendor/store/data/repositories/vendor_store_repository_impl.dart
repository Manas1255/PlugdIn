import 'dart:io';

import 'package:dio/dio.dart';
import 'package:plugdin/constants/app_constants.dart';
import 'package:plugdin/core/api_service/api_service.dart';
import 'package:plugdin/core/app_preferences/app_preferences.dart';
import 'package:plugdin/core/di/injector.dart';
import 'package:plugdin/core/endpoints/endpoints.dart';
import 'package:plugdin/features/vendor/store/data/models/add_review_request_model.dart';
import 'package:plugdin/features/vendor/store/data/models/add_review_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/create_package_request_model.dart';
import 'package:plugdin/features/vendor/store/data/models/features_request_model.dart';
import 'package:plugdin/features/vendor/store/data/models/features_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/package_model.dart';
import 'package:plugdin/features/vendor/store/data/models/store_media_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_features_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_packages_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_store_info_model.dart';
import 'package:plugdin/features/vendor/store/domain/repositories/vendor_store_repository.dart';
import 'package:plugdin/utils/helpers/logger_helper.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';
import 'package:plugdin/utils/response_data_model/api_response_parser.dart';

class VendorStoreRepositoryImpl implements VendorStoreRepository {
  VendorStoreRepositoryImpl({
    ApiService? apiService,
    AppPreferences? baseStorage,
  }) : _apiService = apiService ?? Injector.resolve<ApiService>(),
       _cache = baseStorage ?? Injector.resolve<AppPreferences>();

  final ApiService _apiService;
  final AppPreferences _cache;

  @override
  Future<RepositoryResponse<FeaturesResponseModel>> getStoreFeatures() async {
    try {
      final response = await _apiService.get(
        Endpoints.features,
      );
      final responseData = ApiResponseParser.parse<FeaturesResponseModel>(
        json: response.data,
        fromJson: FeaturesResponseModel.fromJson,
      );
      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData,
      );
    } catch (e, s) {
      AppLogger.error('Error fetching store features', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<VendorFeaturesResponseModel>> updateStoreFeatures(
    FeaturesRequestModel features,
  ) async {
    try {
      final response = await _apiService.post(
        endpoint: Endpoints.features,
        data: features.toJson(),
      );
      final responseData = ApiResponseParser.parse<VendorFeaturesResponseModel>(
        json: response.data,
        fromJson: VendorFeaturesResponseModel.fromJson,
      );
      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData,
      );
    } catch (e, s) {
      AppLogger.error('Error updating store features', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<bool>> uploadStoreMedia(
    List<String> filePaths,
  ) async {
    try {
      AppLogger.info('Uploading media: $filePaths');

      // Convert file paths to MultipartFile objects
      final files = <MultipartFile>[];
      for (final filePath in filePaths) {
        final multipartFile = await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        );
        files.add(multipartFile);
      }

      final response = await _apiService.postMultipart(
        Endpoints.uploadStoreMedia,
        {
          'files': files,
        },
      );
      final responseData = ApiResponseParser.parseBooleanResponse(
        json: response.data,
      );
      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData,
      );
    } catch (e, s) {
      AppLogger.error('Error uploading store media', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<StoreMediaResponseModel>> getStoreMedia({
    int pageNumber = 1,
  }) async {
    try {
      final response = await _apiService.get(
        Endpoints.vendorStoreMedia,
        queryParams: {
          'page': pageNumber,
          'limit': AppConstants.paginationLimit,
        },
      );
      final responseData = ApiResponseParser.parse<StoreMediaResponseModel>(
        json: response.data,
        fromJson: StoreMediaResponseModel.fromJson,
      );
      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData,
      );
    } catch (e, s) {
      AppLogger.error('Error fetching store media', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<bool>> deleteStoreMedia(String postId) async {
    try {
      final response = await _apiService.delete(
        Endpoints.deletePost(postId),
      );
      final responseData = ApiResponseParser.parseBooleanResponse(
        json: response.data,
        successMessage: 'Post deleted successfully',
      );
      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData,
      );
    } catch (e, s) {
      AppLogger.error('Error deleting store media', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<VendorStoreInfoModel>> getVendorStoreInfo() async {
    try {
      final response = await _apiService.get(
        Endpoints.getVendorDetails,
      );
      final responseData =
          ApiResponseParser.parse<VendorStoreInfoResponseModel>(
            json: response.data,
            fromJson: VendorStoreInfoResponseModel.fromJson,
          );
      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData?.vendor,
      );
    } catch (e, s) {
      AppLogger.error('Error fetching vendor store info', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<VendorStoreInfoModel>> getVendorById(
    String vendorId,
  ) async {
    try {
      final response = await _apiService.get(
        Endpoints.getVendorById(vendorId),
      );
      final responseData =
          ApiResponseParser.parse<VendorStoreInfoResponseModel>(
            json: response.data,
            fromJson: VendorStoreInfoResponseModel.fromJson,
          );
      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData?.vendor,
      );
    } catch (e, s) {
      AppLogger.error('Error fetching vendor by ID', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<VendorPackagesResponseModel>> getVendorPackages({
    int pageNumber = 1,
  }) async {
    try {
      final response = await _apiService.get(
        Endpoints.getVendorPackages,
        queryParams: {
          'page': pageNumber,
          'limit': AppConstants.paginationLimit,
        },
      );
      final responseData = ApiResponseParser.parse<VendorPackagesResponseModel>(
        json: response.data,
        fromJson: VendorPackagesResponseModel.fromJson,
      );
      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData,
      );
    } catch (e, s) {
      AppLogger.error('Error fetching vendor packages', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<CreatePackageResponseModel>> createPackage(
    CreatePackageRequestModel package,
  ) async {
    try {
      final hasFiles = package.files.isNotEmpty;

      if (hasFiles) {
        final formData = <String, dynamic>{
          'title': package.title,
          'description': package.description,
          'subprice': package.subprice,
          'totalPrice': package.totalPrice,
          'vendorEmails': package.vendorEmails,
        };

        final files = <MultipartFile>[];
        for (final filePath in package.files) {
          final file = File(filePath);
          if (await file.exists()) {
            final multipartFile = await MultipartFile.fromFile(
              filePath,
              filename: filePath.split('/').last,
            );
            files.add(multipartFile);
          }
        }

        if (files.isNotEmpty) {
          formData['files'] = files;
        }

        final response = await _apiService.postMultipart(
          Endpoints.createPackage,
          formData,
        );
        final responseData =
            ApiResponseParser.parse<CreatePackageResponseModel>(
              json: response.data,
              fromJson: CreatePackageResponseModel.fromJson,
            );
        return RepositoryResponse(
          isSuccess: responseData.isSuccess,
          data: responseData.responseData,
        );
      } else {
        final response = await _apiService.post(
          endpoint: Endpoints.createPackage,
          data: package.toJson(),
        );
        final responseData =
            ApiResponseParser.parse<CreatePackageResponseModel>(
              json: response.data,
              fromJson: CreatePackageResponseModel.fromJson,
            );
        return RepositoryResponse(
          isSuccess: responseData.isSuccess,
          data: responseData.responseData,
        );
      }
    } catch (e, s) {
      AppLogger.error('Error creating package', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<AddReviewResponseModel>> addReview(
    AddReviewRequestModel review,
  ) async {
    try {
      final response = await _apiService.post(
        endpoint: Endpoints.addVendorReview,
        data: review.toJson(),
      );
      final responseData = ApiResponseParser.parse<AddReviewResponseModel>(
        json: response.data,
        fromJson: AddReviewResponseModel.fromJson,
      );
      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData,
      );
    } catch (e, s) {
      AppLogger.error('Error adding review', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }
}
