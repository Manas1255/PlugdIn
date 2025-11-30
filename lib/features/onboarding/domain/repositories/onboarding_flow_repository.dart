import 'package:plugdin/core/enums/role_type.dart';
import 'package:plugdin/core/models/customer_model.dart';
import 'package:plugdin/features/onboarding/data/models/vendor_onboarding_request_model.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';

abstract class OnboardingFlowRepository {
  Future<RepositoryResponse<CustomerModel?>> emailSignUp({
    required String fullName,
    required String email,
    required String password,
    required RoleType role,
    required String userName,
  });

  Future<RepositoryResponse<bool>> vendorEmailSignUp({
    required VendorOnboardingRequestModel vendorOnboardingRequestModel,
  });

  Future<RepositoryResponse<CustomerModel?>> emailLogin({
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

  Future<RepositoryResponse<bool>> googleSignIn();

  Future<RepositoryResponse<bool>> uploadProfileImage({
    required String file,
  });
}
