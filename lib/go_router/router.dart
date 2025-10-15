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
    ],
  );
}
