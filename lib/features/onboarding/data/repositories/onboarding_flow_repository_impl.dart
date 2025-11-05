import 'package:google_sign_in/google_sign_in.dart';
import 'package:plugdin/core/api_service/api_service.dart';
import 'package:plugdin/core/api_service/app_api_exception.dart';
import 'package:plugdin/core/app_preferences/app_preferences.dart';
import 'package:plugdin/core/di/injector.dart';
import 'package:plugdin/core/endpoints/endpoints.dart';
import 'package:plugdin/core/models/customer_model.dart';
import 'package:plugdin/enums/role_type.dart';
import 'package:plugdin/features/onboarding/data/models/auth_response_model.dart';
import 'package:plugdin/features/onboarding/data/models/vendor_onboarding_request_model.dart';
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

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _googleInit = false;

  @override
  Future<RepositoryResponse<bool>> emailSignUp({
    required String fullName,
    required String email,
    required String password,
    required RoleType role,
    required String userName,
  }) async {
    try {
      final response = await _apiService.post(
        endpoint: Endpoints.signup,
        data: {
          'name': fullName,
          'email': email,
          'password': password,
          'role': role.toName,
          'username': userName,
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

  @override
  Future<RepositoryResponse<CustomerModel?>> emailLogin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.post(
        endpoint: Endpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      final responseData = ApiResponseParser.parse<AuthResponseModel>(
        json: response.data,
        fromJson: AuthResponseModel.fromJson,
      );

      if (responseData.isSuccess && responseData.responseData != null) {
        print('in ifff hapa, ${responseData.responseData?.user.role}');
        _cache
          ..setUserModel(responseData.responseData!.user)
          ..setToken(responseData.responseData!.tokens.accessToken);
      }

      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData?.user,
      );
    } catch (e, s) {
      AppLogger.error('Error signing in: ', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<bool>> sendPasswordResetCode({
    required String email,
  }) async {
    try {
      final response = await _apiService.post(
        endpoint: Endpoints.requestPasswordReset,
        data: {
          'email': email,
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
      AppLogger.error('Error sending password reset code: ', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<bool>> verifyPasswordResetCode({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _apiService.post(
        endpoint: Endpoints.verifyResetCode,
        data: {
          'email': email,
          'code': code,
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
      AppLogger.error('Error verifying password reset code: ', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<bool>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      final response = await _apiService.post(
        endpoint: Endpoints.resetPassword,
        data: {
          'email': email,
          'newPassword': newPassword,
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
      AppLogger.error('Error resetting password: ', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  Future<void> _initGoogleSignIn() async {
    if (!_googleInit) {
      await _googleSignIn.initialize(
        serverClientId:
            '65191217222-4j6md0sjqfegulbhme4ofkcq9st8khdn.apps.googleusercontent.com',
      );
      _googleInit = true;
    }
  }

  @override
  Future<RepositoryResponse<bool>> googleSignIn() async {
    try {
      await _initGoogleSignIn();

      final account = await _googleSignIn.authenticate(
        scopeHint: ['email'],
      );

      final auth = account.authentication;
      final idToken = auth.idToken;

      if (idToken == null) {
        throw AppApiException('Failed to retrieve Google ID token');
      }

      final response = await _apiService.post(
        endpoint: Endpoints.googleLogin,
        data: {
          'idToken': idToken,
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
      AppLogger.error('Error with Google Sign-In: ', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }

  @override
  Future<RepositoryResponse<bool>> vendorEmailSignUp({
    required VendorOnboardingRequestModel vendorOnboardingRequestModel,
  }) async {
    try {
      final response = await _apiService.post(
        endpoint: Endpoints.vendorSignup,
        data: vendorOnboardingRequestModel.toJson(),
      );

      final responseData = ApiResponseParser.parseBooleanResponse(
        json: response.data,
      );

      return RepositoryResponse(
        isSuccess: responseData.isSuccess,
        data: responseData.responseData,
      );
    } catch (e, s) {
      AppLogger.error('Error signing up vendor: ', e, s);
      return RepositoryResponse(
        isSuccess: false,
        message: e.toString(),
      );
    }
  }
}
