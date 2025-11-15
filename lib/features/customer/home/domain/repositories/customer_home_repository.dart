import 'package:plugdin/core/enums/category_type.dart';
import 'package:plugdin/core/models/all_vendors_response_model.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';

abstract class CustomerHomeRepository {
  Future<RepositoryResponse<AllVendorsResponseModel>> getAllVendors({
    CategoryType? filter,
  });
}
