import 'package:plugdin/config/api_environment.dart';

class Endpoints {
  Endpoints._();
  static String get baseUrl => ApiEnvironment.current.baseUrl;
  // static String get apiVersion => ApiEnvironment.current.apiVersion;

  /// Authentication Endpoints
  static const String signup = 'auth/register';
  static const String login = 'auth/login';
  static const String logout = 'auth/logout';
  static const String requestPasswordReset = 'auth/forgot-password';
  static const String verifyResetCode = 'auth/verify-code';
  static const String resetPassword = 'auth/reset-password';
  static const String googleLogin = 'auth/google';
  static const String vendorSignup = 'vendor/register';
  static const String changePassword = 'auth/resetpassword';

  /// Profile Endpoints
  static const String getProfileInfo = 'auth/profile';
  static const String updateProfile = 'users/update';
}
