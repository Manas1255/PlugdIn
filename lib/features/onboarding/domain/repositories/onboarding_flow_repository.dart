import 'package:plugdin/enums/role_type.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';

abstract class OnboardingFlowRepository {
  Future<RepositoryResponse<bool>> emailSignUp({
    required String fullName,
    required String email,
    required String password,
    required RoleType role,
    required String userName,
  });

  Future<RepositoryResponse<bool>> emailLogin({
    required String email,
    required String password,
  });

  Future<RepositoryResponse<bool>> sendPasswordResetCode({
    required String email,
  });

  Future<RepositoryResponse<bool>> verifyPasswordResetCode({
    required String email,
    required String code,
  });

  Future<RepositoryResponse<bool>> resetPassword({
    required String email,
    required String newPassword,
  });
}
