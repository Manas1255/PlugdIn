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

      // Customer navigation routes
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
                  final vendorModel = appPreferences.getVendorModel();
                  final customerModel = appPreferences.getUserModel();
                  // Redirect to vendor home if vendor model exists
                  if (vendorModel != null) {
                    return AppRoutes.vendorHomeScreen;
                  }
                  // Redirect to onboarding if customer model doesn't exist
                  if (customerModel == null) {
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
                  final vendorModel = appPreferences.getVendorModel();
                  final customerModel = appPreferences.getUserModel();
                  // Redirect to vendor search if vendor model exists
                  if (vendorModel != null) {
                    return AppRoutes.vendorSearchScreen;
                  }
                  // Redirect to onboarding if customer model doesn't exist
                  if (customerModel == null) {
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
                  final vendorModel = appPreferences.getVendorModel();
                  final customerModel = appPreferences.getUserModel();
                  // Redirect to vendor profile if vendor model exists
                  if (vendorModel != null) {
                    return AppRoutes.vendorProfileScreen;
                  }
                  // Redirect to onboarding if customer model doesn't exist
                  if (customerModel == null) {
                    return AppRoutes.onboarding;
                  }
                  return null;
                },
              ),
            ],
          ),
        ],
        builder: (context, state, shell) {
          final appPreferences = Injector.resolve<AppPreferences>();
          final vendorModel = appPreferences.getVendorModel();
          final customerModel = appPreferences.getUserModel();
          
          // Only show customer navigation if vendor model doesn't exist and customer model exists
          if (vendorModel == null && customerModel != null) {
            return CustomerNavigation(shell: shell);
          }
          // If vendor model exists or customer model doesn't exist, show empty and let vendor route handle it
          return const SizedBox.shrink();
        },
      ),
      // Vendor navigation routes
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
                  final vendorModel = appPreferences.getVendorModel();
                  final customerModel = appPreferences.getUserModel();
                  // Redirect to customer home if vendor model doesn't exist and customer model exists
                  if (vendorModel == null && customerModel != null) {
                    return AppRoutes.customerHomeScreen;
                  }
                  // Redirect to onboarding if neither model exists
                  if (vendorModel == null && customerModel == null) {
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
                builder: (context, state) => const VendorSearchScreen(),
                redirect: (context, state) {
                  final appPreferences = Injector.resolve<AppPreferences>();
                  final vendorModel = appPreferences.getVendorModel();
                  // Redirect to customer search if vendor model doesn't exist
                  if (vendorModel == null) {
                    return AppRoutes.customerSearchScreen;
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
                  final vendorModel = appPreferences.getVendorModel();
                  final customerModel = appPreferences.getUserModel();
                  // Redirect to customer home if vendor model doesn't exist and customer model exists
                  if (vendorModel == null && customerModel != null) {
                    return AppRoutes.customerHomeScreen;
                  }
                  // Redirect to onboarding if neither model exists
                  if (vendorModel == null && customerModel == null) {
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
                  final vendorModel = appPreferences.getVendorModel();
                  final customerModel = appPreferences.getUserModel();
                  // Redirect to customer home if vendor model doesn't exist and customer model exists
                  if (vendorModel == null && customerModel != null) {
                    return AppRoutes.customerHomeScreen;
                  }
                  // Redirect to onboarding if neither model exists
                  if (vendorModel == null && customerModel == null) {
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
                  final vendorModel = appPreferences.getVendorModel();
                  final customerModel = appPreferences.getUserModel();
                  // Redirect to customer profile if vendor model doesn't exist and customer model exists
                  if (vendorModel == null && customerModel != null) {
                    return AppRoutes.customerProfileScreen;
                  }
                  // Redirect to onboarding if neither model exists
                  if (vendorModel == null && customerModel == null) {
                    return AppRoutes.onboarding;
                  }
                  return null;
                },
              ),
            ],
          ),
        ],
        builder: (context, state, shell) {
          final appPreferences = Injector.resolve<AppPreferences>();
          final vendorModel = appPreferences.getVendorModel();
          
          // Only show vendor navigation if vendor model exists
          if (vendorModel != null) {
            return VendorNavigation(shell: shell);
          }
          // If vendor model doesn't exist, show empty and let customer route handle it
          return const SizedBox.shrink();
        },
      ),
    ],
  );
}
