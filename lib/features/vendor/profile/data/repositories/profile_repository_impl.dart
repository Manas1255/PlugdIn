import 'package:plugdin/core/api_service/api_service.dart';
import 'package:plugdin/core/app_preferences/app_preferences.dart';
import 'package:plugdin/core/di/injector.dart';
import 'package:plugdin/core/endpoints/endpoints.dart';
import 'package:plugdin/core/models/vendor_model.dart';
import 'package:plugdin/features/vendor/profile/data/models/profile_response_model.dart';
import 'package:plugdin/features/vendor/profile/domain/repositories/profile_repository.dart';
import 'package:plugdin/utils/helpers/logger_helper.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';
import 'package:plugdin/utils/response_data_model/api_response_parser.dart';

class VendorProfileRepositoryImpl implements VendorProfileRepository {
  VendorProfileRepositoryImpl({
    ApiService? apiService,
    AppPreferences? baseStorage,
  }) : _apiService = apiService ?? Injector.resolve<ApiService>(),
       _cache = baseStorage ?? Injector.resolve<AppPreferences>();

  final ApiService _apiService;
  final AppPreferences _cache;

  @override
  Future<RepositoryResponse<VendorModel>> fetchProfileInfo() async {
    try {
      // final userModel = _cache.getUserModel();
      // if (userModel != null && !forceRefresh) {
      //   return RepositoryResponse(
      //     isSuccess: true,
      //     data: userModel,
      //   );
      // }

      final response = await _apiService.get(
        Endpoints.getProfileInfo,
      );

      final responseData = ApiResponseParser.parse<VendorProfileResponseModel>(
        json: response.data,
        fromJson: VendorProfileResponseModel.fromJson,
      );

      if (responseData.isSuccess && responseData.responseData != null) {
        _cache.setVendorModel(responseData.responseData!.vendor);
      }

      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData?.vendor,
      );
    } catch (e, s) {
      AppLogger.error('Error fetching profile info:', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<bool>> logout() async {
    try {
      final response = await _apiService.post(
        endpoint: Endpoints.logout,
      );
      final responseData = ApiResponseParser.parseBooleanResponse(
        json: response.data,
      );
      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData ?? false,
      );
    } catch (e, s) {
      AppLogger.error('Error logging out:', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<VendorModel>> updateProfileInfo({
    required String name,
    required String username,
  }) async {
    try {
      final response = await _apiService.put(
        Endpoints.updateProfile,
        {
          'name': name,
          'username': username,
        },
      );

      final responseData = ApiResponseParser.parse<VendorProfileResponseModel>(
        json: response.data,
        fromJson: VendorProfileResponseModel.fromJson,
      );

      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData?.vendor,
      );
    } catch (e, s) {
      AppLogger.error('Error updating profile info:', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<bool>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _apiService.put(
        Endpoints.changePassword,
        {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
      );

      final responseData = ApiResponseParser.parseBooleanResponse(
        json: response.data,
      );

      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData ?? false,
      );
    } catch (e, s) {
      AppLogger.error('Error changing password:', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<bool>> updateUserPreferences({
    bool? inAppNotifications,
  }) async {
    try {
      final response = await _apiService.patch(
        Endpoints.setNotification,
        {},
      );

      final responseData = ApiResponseParser.parseBooleanResponse(
        json: response.data,
      );

      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData,
      );
    } catch (e, s) {
      AppLogger.error('Error updating user preferences: ', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<bool>> deleteAccount() async {
    try {
      final response = await _apiService.delete(
        Endpoints.deleteAccount,
      );

      final responseData = ApiResponseParser.parseBooleanResponse(
        json: response.data,
      );

      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData ?? false,
      );
    } catch (e, s) {
      AppLogger.error('Error deleting account: ', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }
}
