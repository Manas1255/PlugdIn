import 'package:plugdin/constants/app_constants.dart';
import 'package:plugdin/core/api_service/api_service.dart';
import 'package:plugdin/core/di/injector.dart';
import 'package:plugdin/core/endpoints/endpoints.dart';
import 'package:plugdin/features/customer/store/domain/repositories/customer_store_repository.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_packages_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_reviews_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_store_info_model.dart';
import 'package:plugdin/utils/helpers/logger_helper.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';
import 'package:plugdin/utils/response_data_model/api_response_parser.dart';

class CustomerStoreRepositoryImpl implements CustomerStoreRepository {
  CustomerStoreRepositoryImpl({
    ApiService? apiService,
  }) : _apiService = apiService ?? Injector.resolve<ApiService>();

  final ApiService _apiService;

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
  Future<RepositoryResponse<VendorPackagesResponseModel>> getVendorPackagesById({
    required String vendorId,
    int pageNumber = 1,
  }) async {
    try {
      final response = await _apiService.get(
        Endpoints.getAllPackages,
        queryParams: {
          'page': pageNumber,
          'limit': AppConstants.paginationLimit,
          'vendorId': vendorId,
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
      AppLogger.error('Error fetching vendor packages by ID', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<VendorReviewsResponseModel>> getVendorReviewsById({
    required String vendorId,
    int pageNumber = 1,
  }) async {
    try {
      final response = await _apiService.get(
        Endpoints.getVendorReviewsById(vendorId),
        queryParams: {
          'page': pageNumber,
          'limit': AppConstants.paginationLimit,
        },
      );
      final responseData = ApiResponseParser.parse<VendorReviewsResponseModel>(
        json: response.data,
        fromJson: VendorReviewsResponseModel.fromJson,
      );
      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData,
      );
    } catch (e, s) {
      AppLogger.error('Error fetching vendor reviews by ID', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }
}
