import 'package:plugdin/config/api_environment.dart';

class Endpoints {
  Endpoints._();
  static String get baseUrl => ApiEnvironment.current.baseUrl;
  // static String get apiVersion => ApiEnvironment.current.apiVersion;

  /// Authentication Endpoints
  static const String signup = 'auth/register';
  static const String login = 'auth/login';
  static const String requestPasswordReset = 'auth/request-password-reset';
}
