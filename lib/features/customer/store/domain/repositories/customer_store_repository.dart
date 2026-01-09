import 'package:plugdin/features/vendor/store/data/models/vendor_packages_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_reviews_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_store_info_model.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';

abstract class CustomerStoreRepository {
  Future<RepositoryResponse<VendorStoreInfoModel>> getVendorById(
    String vendorId,
  );

  Future<RepositoryResponse<VendorPackagesResponseModel>> getVendorPackagesById({
    required String vendorId,
    int pageNumber = 1,
  });

  Future<RepositoryResponse<VendorReviewsResponseModel>> getVendorReviewsById({
    required String vendorId,
    int pageNumber = 1,
  });
}
