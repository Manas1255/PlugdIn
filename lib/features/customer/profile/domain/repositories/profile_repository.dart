import 'package:plugdin/core/models/customer_model.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';

abstract class CustomerProfileRepository {
  Future<RepositoryResponse<CustomerModel>> fetchProfileInfo();

  Future<RepositoryResponse<bool>> logout();

  Future<RepositoryResponse<CustomerModel>> updateProfileInfo({
    required String name,
    required String username,
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
