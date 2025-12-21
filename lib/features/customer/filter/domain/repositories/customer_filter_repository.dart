import 'package:plugdin/core/models/filtered_vendors_response_model.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';

abstract class CustomerFilterRepository {
  Future<RepositoryResponse<FilteredVendorsResponseModel>> getFilteredVendors({
    String? category,
    String? city,
    double? priceFrom,
    double? priceTo,
    int? capacity,
    String? feature,
    int page = 1,
    int limit = 10,
  });
}

