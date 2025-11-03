import 'package:plugdin/core/models/user_model.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';

abstract class ProfileRepository {
  Future<RepositoryResponse<UserModel>> fetchProfileInfo();

  Future<RepositoryResponse<bool>> logout();

  Future<RepositoryResponse<UserModel>> updateProfileInfo({
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
