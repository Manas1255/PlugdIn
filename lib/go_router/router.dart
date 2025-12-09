part of 'exports.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  factory AppRouter() => _instance;

  AppRouter._internal();

  static final AppRouter _instance = AppRouter._internal();

  static BuildContext? get appContext =>
      AppRouter.router.routerDelegate.navigatorKey.currentContext;

  static String getCurrentLocation() {
    if (appContext == null) {
      throw Exception(
        'AppRouter.appContext is null. Ensure the appContext is initialized.',
      );
    }

    final router = GoRouter.of(appContext!);

    final configuration = router.routerDelegate.currentConfiguration;

    final lastMatch = configuration.last;
    final matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : configuration;

    final currentLocation = matchList.uri.toString();
    return currentLocation;
  }

  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: AppRouteNames.splash,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: AppRouteNames.onboarding,
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.customerSignUpScreen,
        name: AppRouteNames.customerSignUpScreen,
        builder: (context, state) {
          return CustomerSignupScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.vendorSignUpScreen,
        name: AppRouteNames.vendorSignUpScreen,
        builder: (context, state) {
          return VendorSignupScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.vendorOnboardingSuccessScreen,
        name: AppRouteNames.vendorOnboardingSuccessScreen,
        builder: (context, state) {
          return VendorOnboardingSuccessScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.loginScreen,
        name: AppRouteNames.loginScreen,
        builder: (context, state) {
          return LoginScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.roleSelectionScreen,
        name: AppRouteNames.roleSelectionScreen,
        builder: (context, state) {
          return const RoleSelectionScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.forgotPasswordScreen,
        name: AppRouteNames.forgotPasswordScreen,
        builder: (context, state) {
          return ForgotPasswordScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.resetCodeScreen,
        name: AppRouteNames.resetCodeScreen,
        builder: (context, state) {
          return ResetCodeScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.newPasswordScreen,
        name: AppRouteNames.newPasswordScreen,
        builder: (context, state) {
          return NewPasswordScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.customerPersonalInfoScreen,
        name: AppRouteNames.customerPersonalInfoScreen,
        builder: (context, state) {
          return CustomerPersonalInfoScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.vendorPersonalInfoScreen,
        name: AppRouteNames.vendorPersonalInfoScreen,
        builder: (context, state) {
          return VendorPersonalInfoScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.customerChangePasswordScreen,
        name: AppRouteNames.customerChangePasswordScreen,
        builder: (context, state) {
          return CustomerChangePasswordScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.vendorChangePasswordScreen,
        name: AppRouteNames.vendorChangePasswordScreen,
        builder: (context, state) {
          return VendorChangePasswordScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.addFeaturesScreen,
        name: AppRouteNames.addFeaturesScreen,
        builder: (context, state) {
          return AddFeaturesScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.createPackageScreen,
        name: AppRouteNames.createPackageScreen,
        builder: (context, state) {
          return const CreatePackageScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.vendorNotificationsScreen,
        name: AppRouteNames.vendorNotificationsScreen,
        builder: (context, state) {
          return VendorNotificationsScreen();
        },
      ),

      GoRoute(
        path: '${AppRoutes.vendorOtherVendorStoreScreen}/:vendorId',
        name: AppRouteNames.vendorOtherVendorStoreScreen,
        builder: (context, state) {
          final vendorId = state.pathParameters['vendorId'] ?? '';
          return OtherVendorStoreScreen(vendorId: vendorId);
        },
      ),

      GoRoute(
        path: AppRoutes.browseScreen,
        name: AppRouteNames.browseScreen,
        builder: (context, state) {
          return const BrowseScreen();
        },
      ),

      StatefulShellRoute.indexedStack(
        branches: [
          StatefulShellBranch(
            initialLocation: AppRoutes.customerHomeScreen,
            routes: [
              GoRoute(
                path: AppRoutes.customerHomeScreen,
                name: AppRouteNames.customerHomeScreen,
                builder: (context, state) => const CustomerHomeScreen(),
                redirect: (context, state) {
                  final appPreferences = Injector.resolve<AppPreferences>();
                  if (appPreferences.isCustomer()) {
                    return AppRoutes.customerHomeScreen;
                  }
                  if (appPreferences.isVendor()) {
                    return AppRoutes.onboarding;
                  }
                  return null;
                },
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: AppRoutes.customerSearchScreen,
            routes: [
              GoRoute(
                path: AppRoutes.customerSearchScreen,
                name: AppRouteNames.customerSearchScreen,
                builder: (context, state) => const CustomerSearchScreen(),
                redirect: (context, state) {
                  final appPreferences = Injector.resolve<AppPreferences>();
                  if (appPreferences.isCustomer()) {
                    return AppRoutes.customerSearchScreen;
                  }
                  if (appPreferences.isVendor()) {
                    return AppRoutes.onboarding;
                  }
                  return null;
                },
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: AppRoutes.customerProfileScreen,
            routes: [
              GoRoute(
                path: AppRoutes.customerProfileScreen,
                name: AppRouteNames.customerProfileScreen,
                builder: (context, state) => const CustomerProfileScreen(),
                redirect: (context, state) {
                  final appPreferences = Injector.resolve<AppPreferences>();
                  if (appPreferences.isCustomer()) {
                    return AppRoutes.customerProfileScreen;
                  }
                  if (appPreferences.isVendor()) {
                    return AppRoutes.onboarding;
                  }
                  return null;
                },
              ),
            ],
          ),
        ],
        builder: (context, state, shell) {
          return CustomerNavigation(shell: shell);
        },
      ),

      StatefulShellRoute.indexedStack(
        branches: [
          StatefulShellBranch(
            initialLocation: AppRoutes.vendorHomeScreen,
            routes: [
              GoRoute(
                path: AppRoutes.vendorHomeScreen,
                name: AppRouteNames.vendorHomeScreen,
                builder: (context, state) => const VendorHomeScreen(),
                redirect: (context, state) {
                  final appPreferences = Injector.resolve<AppPreferences>();
                  if (appPreferences.isVendor()) {
                    return AppRoutes.vendorHomeScreen;
                  }
                  if (appPreferences.isCustomer()) {
                    return AppRoutes.onboarding;
                  }
                  return null;
                },
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: AppRoutes.vendorSearchScreen,
            routes: [
              GoRoute(
                path: AppRoutes.vendorSearchScreen,
                name: AppRouteNames.vendorSearchScreen,
                builder: (context, state) => VendorSearchScreen(),
                redirect: (context, state) {
                  final appPreferences = Injector.resolve<AppPreferences>();
                  if (appPreferences.isVendor()) {
                    return AppRoutes.vendorSearchScreen;
                  }
                  if (appPreferences.isCustomer()) {
                    return AppRoutes.onboarding;
                  }
                  return null;
                },
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: AppRoutes.vendorPostScreen,
            routes: [
              GoRoute(
                path: AppRoutes.vendorPostScreen,
                name: AppRouteNames.vendorPostScreen,
                builder: (context, state) => const VendorPostScreen(),
                redirect: (context, state) {
                  final appPreferences = Injector.resolve<AppPreferences>();
                  if (appPreferences.isVendor()) {
                    return AppRoutes.vendorPostScreen;
                  }
                  if (appPreferences.isCustomer()) {
                    return AppRoutes.onboarding;
                  }
                  return null;
                },
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: AppRoutes.vendorStoreScreen,
            routes: [
              GoRoute(
                path: AppRoutes.vendorStoreScreen,
                name: AppRouteNames.vendorStoreScreen,
                builder: (context, state) => const VendorStoreScreen(),
                redirect: (context, state) {
                  final appPreferences = Injector.resolve<AppPreferences>();
                  if (appPreferences.isVendor()) {
                    return AppRoutes.vendorStoreScreen;
                  }
                  if (appPreferences.isCustomer()) {
                    return AppRoutes.onboarding;
                  }
                  return null;
                },
              ),
            ],
          ),
          StatefulShellBranch(
            initialLocation: AppRoutes.vendorProfileScreen,
            routes: [
              GoRoute(
                path: AppRoutes.vendorProfileScreen,
                name: AppRouteNames.vendorProfileScreen,
                builder: (context, state) => const VendorProfileScreen(),
                redirect: (context, state) {
                  final appPreferences = Injector.resolve<AppPreferences>();
                  if (appPreferences.isVendor()) {
                    return AppRoutes.vendorProfileScreen;
                  }
                  if (appPreferences.isCustomer()) {
                    return AppRoutes.onboarding;
                  }
                  return null;
                },
              ),
            ],
          ),
        ],
        builder: (context, state, shell) {
          return VendorNavigation(shell: shell);
        },
      ),
    ],
  );
}
