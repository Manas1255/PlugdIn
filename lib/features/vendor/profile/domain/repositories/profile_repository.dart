import 'package:plugdin/core/models/vendor_model.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';

abstract class VendorProfileRepository {
  Future<RepositoryResponse<VendorModel>> fetchProfileInfo();

  Future<RepositoryResponse<bool>> logout();

  Future<RepositoryResponse<VendorModel>> updateProfileInfo({
    required String companyName,
    required String personName,
    required String address,
    required String city,
    required String phoneNumber,
    required String businessDescription,
  });

  Future<RepositoryResponse<bool>> changePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<RepositoryResponse<bool>> updateUserPreferences({
    bool? inAppNotifications,
  });

  Future<RepositoryResponse<bool>> deleteAccount();
}
