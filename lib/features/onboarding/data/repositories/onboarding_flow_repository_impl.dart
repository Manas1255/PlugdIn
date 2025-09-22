import 'package:plugdin/core/api_service/api_service.dart';
import 'package:plugdin/core/app_preferences/app_preferences.dart';
import 'package:plugdin/core/di/injector.dart';
import 'package:plugdin/features/onboarding/domain/repositories/onboarding_flow_repository.dart';

class OnboardingFlowRepositoryImpl implements OnboardingFlowRepository {
  OnboardingFlowRepositoryImpl({
    ApiService? apiService,
    AppPreferences? baseStorage,
  }) : _apiService = apiService ?? Injector.resolve<ApiService>(),
       _cache = baseStorage ?? Injector.resolve<AppPreferences>();

  final ApiService _apiService;
  final AppPreferences _cache;
}
