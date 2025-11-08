import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/core/api_service/api_service.dart';
import 'package:plugdin/core/app_preferences/app_preferences.dart';
import 'package:plugdin/core/di/injector.dart';
import 'package:plugdin/core/endpoints/endpoints.dart';
import 'package:plugdin/features/customer/profile/presentation/cubit/cubit.dart';
import 'package:plugdin/features/customer/profile/presentation/cubit/state.dart';
import 'package:plugdin/features/vendor/profile/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/profile/presentation/cubit/state.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/utils/helpers/data_state.dart';
import 'package:plugdin/utils/helpers/logger_helper.dart';

class DeleteAccountService {
  DeleteAccountService({
    ApiService? apiService,
    AppPreferences? appPreferences,
  }) : _apiService = apiService ?? Injector.resolve<ApiService>(),
       _appPreferences = appPreferences ?? Injector.resolve<AppPreferences>();

  final ApiService _apiService;
  final AppPreferences _appPreferences;

  Future<bool> deleteAccount({
    CustomerProfileCubit? customerProfileCubit,
    VendorProfileCubit? vendorProfileCubit,
    BuildContext? context,
  }) async {
    try {
      final endpoint = vendorProfileCubit != null
          ? Endpoints.deleteVendorAccount
          : Endpoints.deleteCustomerAccount;

      await _apiService.delete(endpoint);

      await _clearAllStates(
        customerProfileCubit: customerProfileCubit,
        vendorProfileCubit: vendorProfileCubit,
      );
      _navigateToOnboarding(context);
      return true;
    } catch (e, s) {
      AppLogger.error('Error during account deletion:', e, s);

      await _clearAllStates(
        customerProfileCubit: customerProfileCubit,
        vendorProfileCubit: vendorProfileCubit,
      );
      _navigateToOnboarding(context);
      return false;
    }
  }

  Future<void> _clearAllStates({
    CustomerProfileCubit? customerProfileCubit,
    VendorProfileCubit? vendorProfileCubit,
  }) async {
    _appPreferences
      ..clearAuthData()
      ..removeUserModel()
      ..clearAll();

    if (customerProfileCubit != null) {
      customerProfileCubit.emit(
        const CustomerProfileState(
          notificationsEnabled: false,
          profileInfo: DataState.initial(),
          changePassword: DataState.initial(),
          userPreferences: DataState.initial(),
          deleteAccount: DataState.initial(),
        ),
      );
    }

    if (vendorProfileCubit != null) {
      vendorProfileCubit.emit(
        VendorProfileState(
          notificationsEnabled: false,
          profileInfo: const DataState.initial(),
          changePassword: const DataState.initial(),
          userPreferences: const DataState.initial(),
          deleteAccount: const DataState.initial(),
        ),
      );
    }
  }

  void _navigateToOnboarding(BuildContext? context) {
    final navigationContext = context ?? AppRouter.appContext;
    if (navigationContext != null) {
      navigationContext.goNamed(AppRouteNames.onboarding);
    } else {
      AppRouter.router.go(AppRoutes.onboarding);
    }
  }
}
