import 'package:plugdin/constants/app_constants.dart';
import 'package:plugdin/core/api_service/api_service.dart';
import 'package:plugdin/core/app_preferences/app_preferences.dart';
import 'package:plugdin/core/di/injector.dart';
import 'package:plugdin/core/endpoints/endpoints.dart';
import 'package:plugdin/core/models/filtered_vendors_response_model.dart';
import 'package:plugdin/features/vendor/filter/domain/repositories/vendor_filter_repository.dart';
import 'package:plugdin/utils/helpers/logger_helper.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';
import 'package:plugdin/utils/response_data_model/api_response_parser.dart';

class VendorFilterRepositoryImpl implements VendorFilterRepository {
  VendorFilterRepositoryImpl({
    ApiService? apiService,
    AppPreferences? baseStorage,
  }) : _apiService = apiService ?? Injector.resolve<ApiService>(),
       _cache = baseStorage ?? Injector.resolve<AppPreferences>();

  final ApiService _apiService;
  final AppPreferences _cache;

  @override
  Future<RepositoryResponse<FilteredVendorsResponseModel>> getFilteredVendors({
    String? category,
    String? city,
    double? priceFrom,
    double? priceTo,
    int? capacity,
    String? feature,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };

      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }
      if (city != null && city.isNotEmpty) {
        queryParams['city'] = city;
      }
      if (priceFrom != null) {
        queryParams['priceFrom'] = priceFrom;
      }
      if (priceTo != null) {
        queryParams['priceTo'] = priceTo;
      }
      if (capacity != null) {
        queryParams['capacity'] = capacity;
      }
      if (feature != null && feature.isNotEmpty) {
        queryParams['feature'] = feature;
      }

      final response = await _apiService.get(
        Endpoints.getFilteredVendors,
        queryParams: queryParams,
      );

      final responseData = ApiResponseParser.parse<FilteredVendorsResponseModel>(
        json: response.data,
        fromJson: FilteredVendorsResponseModel.fromJson,
      );

      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData,
        message: responseData.responseMessage,
      );
    } catch (e, s) {
      AppLogger.error('Error fetching filtered vendors: ', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }
}
