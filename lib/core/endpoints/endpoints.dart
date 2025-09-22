import 'package:plugdin/config/api_environment.dart';

class Endpoints {
  Endpoints._();
  static String get baseUrl => ApiEnvironment.current.baseUrl;
  static String get apiVersion => ApiEnvironment.current.apiVersion;

  /// Authentication Endpoints
  static const String signup = 'auth/signup';
  static const String login = 'auth/login';
  static const String verifyEmailOTP = 'auth/verify-email-code';
  static const String resendEmailOTP = 'auth/resend-email-verification-code';
  static const String forgotPassword = 'auth/forgot-password';
  static const String verifyPasswordOTP = 'auth/verify-reset-code';
  static const String resetPassword = 'auth/set-new-password-after-code';

  ///Profile Endpoints
  static const String getUser = 'profile';
  static const String updateUser = 'profile';
  static const String deleteAccount = 'profile';
  static const String updateUserPassword = 'profile/password';
  static const String setFCMToken = 'profile/fcm-token';

  ///Events, Fights & Active Alarms Endpoints
  static const String getAllEvents = 'events';
  static const String getAllFights = 'fights';
  static const String setReminderForAFight = 'reminders';
  static const String disableReminderForAFight = 'reminders/disable';
  static const String getAllActiveAlarms = 'fights/alarms/active';

  static const String aboutUs = 'about-us';
}
