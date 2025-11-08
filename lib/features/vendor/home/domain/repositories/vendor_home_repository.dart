import 'package:plugdin/core/models/all_vendors_response_model.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';

abstract class VendorHomeRepository {
  Future<RepositoryResponse<AllVendorsResponseModel>> getAllVendors();
}
