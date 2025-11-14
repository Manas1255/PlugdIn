import 'package:plugdin/core/app_preferences/base_storage.dart';
import 'package:plugdin/core/enums/role_type.dart';
import 'package:plugdin/core/models/customer_model.dart';
import 'package:plugdin/core/models/vendor_model.dart';

class AppPreferences extends BaseStorage {
  AppPreferences() {
    init('app-storage');
  }

  final String _authTokenKey = 'auth_token';
  final String _userIdKey = 'user_id';
  final String _refreshTokenKey = 'refresh_token';
  final String _appLocale = 'app_locale';
  final String _userModelKey = 'user_model';
  final String _vendorModelKey = 'vendor_model';
  final String _adsRemovedKey = 'ads_removed';

  void setAppLocale(String locale) {
    store<String>(_appLocale, locale);
  }

  void clearAppLocale() {
    remove(_appLocale);
  }

  String? getAppLocale() {
    return retrieve<String>(_appLocale);
  }

  void setToken(String token) {
    store<String>(_authTokenKey, token);
  }

  String? getToken() {
    return retrieve<String>(_authTokenKey);
  }

  void setUserId(String userId) {
    store<String>(_userIdKey, userId);
  }

  String? getUserId() {
    return retrieve<String>(_userIdKey);
  }

  void setRefreshToken(String token) {
    store<String>(_refreshTokenKey, token);
  }

  String? getRefreshToken() {
    return retrieve<String>(_refreshTokenKey);
  }

  void setUserModel(CustomerModel user) {
    store<CustomerModel>(_userModelKey, user);
  }

  CustomerModel? getUserModel() {
    return retrieve<CustomerModel>(_userModelKey);
  }

  void removeUserModel() {
    remove(_userModelKey);
  }

  void setVendorModel(VendorModel vendor) {
    store<VendorModel>(_vendorModelKey, vendor);
  }

  VendorModel? getVendorModel() {
    return retrieve<VendorModel>(_vendorModelKey);
  }

  void removeVendorModel() {
    remove(_vendorModelKey);
  }

  void clearAuthData() {
    remove(_authTokenKey);
    remove(_refreshTokenKey);
    remove(_userIdKey);
  }

  void clearAll() {
    removeAll();
  }

  Future<void> setAdsRemoved({required bool value}) {
    return store<bool>(_adsRemovedKey, value);
  }

  bool getAdsRemoved() {
    return retrieve<bool>(_adsRemovedKey) ?? false;
  }

  Future<void> clearAdsRemoved() {
    return remove(_adsRemovedKey);
  }

  RoleType? getUserRole() {
    if (!hasData(_userModelKey)) {
      return null;
    }

    final userModel = retrieve<CustomerModel>(_userModelKey);
    return userModel?.role;
  }

  bool isVendor() {
    final role = getUserRole();
    print('vendor role: $role');
    return role == RoleType.vendor;
  }

  bool isCustomer() {
    final role = getUserRole();
    print('customer role: $role');
    return role == RoleType.customer;
  }
}
