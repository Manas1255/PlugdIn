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

  /// Customer Profile Endpoints
  static const String getProfileInfo = 'auth/profile';
  static const String updateCustomerProfile = 'users/update';
  static const String setNotification = 'users/notifications/toggle';
  static const String deleteCustomerAccount = 'users/delete';
  static const String uploadProfilePicture = 'users/profile/upload-picture';

  /// Vendor Endpoints
  static const String getAllVendors = 'vendor/all';
  static const String getVendorDetails = 'vendor';
  static String getVendorById(String vendorId) => 'vendor/$vendorId';
  static const String deleteVendorAccount = 'vendor/delete';
  static const String updateVendorProfile = 'vendor/profile';
  static const String features = 'vendor/features';
  static const String uploadStoreMedia = 'vendor/upload-media';
  static const String vendorStoreMedia = 'vendor/storemedia/vendor';
  static String deletePost(String postId) => 'vendor/storemedia/$postId';
  static const String uploadCompanyLogo = 'vendor/upload-logo';
  static const String createPackage = 'packages';
  static const String getVendorPackages = 'packages/my';
  static const String getAllPackages = 'packages';
  static String getPackageById(String packageId) => 'packages/$packageId';

  /// Filter Endpoints
  static const String getFilterData = 'vendor/filter';
  static const String getFilteredVendors = 'vendor/filter';
}
