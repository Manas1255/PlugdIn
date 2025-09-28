import 'package:plugdin/enums/role_type.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';

abstract class OnboardingFlowRepository {
  Future<RepositoryResponse<bool>> emailSignUp({
    required String fullName,
    required String email,
    required String password,
    required RoleType role,
  });
}
