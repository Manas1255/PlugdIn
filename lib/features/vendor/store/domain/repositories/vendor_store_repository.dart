import 'package:plugdin/features/vendor/store/data/models/features_request_model.dart';
import 'package:plugdin/features/vendor/store/data/models/features_response_model.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';

abstract class VendorStoreRepository {
  Future<RepositoryResponse<FeaturesResponseModel>> getStoreFeatures();
  Future<RepositoryResponse<bool>> updateStoreFeatures(
    FeaturesRequestModel features,
  );
}
