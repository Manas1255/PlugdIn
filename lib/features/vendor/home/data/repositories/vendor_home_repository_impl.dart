import 'package:plugdin/constants/app_constants.dart';
import 'package:plugdin/core/api_service/api_service.dart';
import 'package:plugdin/core/app_preferences/app_preferences.dart';
import 'package:plugdin/core/di/injector.dart';
import 'package:plugdin/core/endpoints/endpoints.dart';
import 'package:plugdin/core/enums/category_type.dart';
import 'package:plugdin/core/models/all_vendors_response_model.dart';
import 'package:plugdin/features/vendor/home/domain/repositories/vendor_home_repository.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_packages_response_model.dart';
import 'package:plugdin/utils/helpers/logger_helper.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';
import 'package:plugdin/utils/response_data_model/api_response_parser.dart';

class VendorHomeRepositoryImpl implements VendorHomeRepository {
  VendorHomeRepositoryImpl({
    ApiService? apiService,
    AppPreferences? baseStorage,
  }) : _apiService = apiService ?? Injector.resolve<ApiService>(),
       _cache = baseStorage ?? Injector.resolve<AppPreferences>();

  final ApiService _apiService;
  final AppPreferences _cache;

  @override
  Future<RepositoryResponse<AllVendorsResponseModel>> getAllVendors({
    CategoryType? filter,
    int pageNumber = 1,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': pageNumber,
        'limit': AppConstants.paginationLimit,
      };
      if (filter != null) {
        queryParams['category'] = filter.toName();
      }

      final response = await _apiService.get(
        Endpoints.getAllVendors,
        queryParams: queryParams,
      );

      final responseData = ApiResponseParser.parse<AllVendorsResponseModel>(
        json: response.data,
        fromJson: AllVendorsResponseModel.fromJson,
      );

      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData,
      );
    } catch (e, s) {
      AppLogger.error('Error fetching all vendors: ', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<VendorPackagesResponseModel>> getAllPackages({
    int pageNumber = 1,
  }) async {
    try {
      final response = await _apiService.get(
        Endpoints.getAllPackages,
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
      AppLogger.error('Error fetching all packages: ', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }
}
