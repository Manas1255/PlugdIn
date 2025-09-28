import 'package:plugdin/core/api_service/api_service.dart';
import 'package:plugdin/core/app_preferences/app_preferences.dart';
import 'package:plugdin/core/di/injector.dart';
import 'package:plugdin/core/endpoints/endpoints.dart';
import 'package:plugdin/enums/role_type.dart';
import 'package:plugdin/features/onboarding/domain/repositories/onboarding_flow_repository.dart';
import 'package:plugdin/utils/helpers/logger_helper.dart';
import 'package:plugdin/utils/helpers/repository_response.dart';
import 'package:plugdin/utils/response_data_model/api_response_parser.dart';

class OnboardingFlowRepositoryImpl implements OnboardingFlowRepository {
  OnboardingFlowRepositoryImpl({
    ApiService? apiService,
    AppPreferences? baseStorage,
  }) : _apiService = apiService ?? Injector.resolve<ApiService>(),
       _cache = baseStorage ?? Injector.resolve<AppPreferences>();

  final ApiService _apiService;
  final AppPreferences _cache;

  @override
  Future<RepositoryResponse<bool>> emailSignUp({
    required String fullName,
    required String email,
    required String password,
    required RoleType role,
  }) async {
    try {
      final response = await _apiService.post(
        endpoint: Endpoints.signup,
        data: {
          'name': fullName,
          'email': email,
          'password': password,
          'role': role.toName,
        },
      );

      final responseData = ApiResponseParser.parseBooleanResponse(
        json: response.data,
      );

      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData,
      );
    } catch (e, s) {
      AppLogger.error('Error signing up: ', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }
}
