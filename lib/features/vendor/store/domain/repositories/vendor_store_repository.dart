import 'package:plugdin/features/vendor/store/data/models/features_response_model.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';

abstract class VendorStoreRepository {
  Future<RepositoryResponse<FeaturesResponseModel>> getStoreFeatures();
}
