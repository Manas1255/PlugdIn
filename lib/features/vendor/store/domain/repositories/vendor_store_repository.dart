import 'package:plugdin/features/vendor/store/data/models/add_review_request_model.dart';
import 'package:plugdin/features/vendor/store/data/models/add_review_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/create_package_request_model.dart';
import 'package:plugdin/features/vendor/store/data/models/features_request_model.dart';
import 'package:plugdin/features/vendor/store/data/models/features_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/package_model.dart';
import 'package:plugdin/features/vendor/store/data/models/store_media_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_features_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_packages_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_reviews_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_store_info_model.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';

abstract class VendorStoreRepository {
  Future<RepositoryResponse<FeaturesResponseModel>> getStoreFeatures();
  Future<RepositoryResponse<VendorFeaturesResponseModel>> updateStoreFeatures(
    FeaturesRequestModel features,
  );

  Future<RepositoryResponse<bool>> uploadStoreMedia(
    List<String> filePaths,
  );

  Future<RepositoryResponse<StoreMediaResponseModel>> getStoreMedia({
    int pageNumber = 1,
  });

  Future<RepositoryResponse<bool>> deleteStoreMedia(String postId);

  Future<RepositoryResponse<VendorStoreInfoModel>> getVendorStoreInfo();

  Future<RepositoryResponse<VendorStoreInfoModel>> getVendorById(
    String vendorId,
  );

  Future<RepositoryResponse<CreatePackageResponseModel>> createPackage(
    CreatePackageRequestModel package,
  );

  Future<RepositoryResponse<VendorPackagesResponseModel>> getVendorPackages({
    int pageNumber = 1,
  });

  Future<RepositoryResponse<AddReviewResponseModel>> addReview(
    AddReviewRequestModel review,
  );

  Future<RepositoryResponse<VendorReviewsResponseModel>> getVendorReviews({
    int pageNumber = 1,
  });
}
