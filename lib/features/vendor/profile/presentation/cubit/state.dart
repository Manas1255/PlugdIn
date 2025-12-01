import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:plugdin/core/models/vendor_model.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class VendorProfileState extends Equatable {
  const VendorProfileState({
    this.notificationsEnabled = false,
    this.profileInfo = const DataState.initial(),
    this.changePassword = const DataState.initial(),
    this.userPreferences = const DataState.initial(),
    this.deleteAccount = const DataState.initial(),
    this.companyLogoFile,
    this.uploadCompanyLogo = const DataState.initial(),
  });

  final bool notificationsEnabled;
  final DataState<VendorModel> profileInfo;
  final DataState<bool> changePassword;
  final DataState<bool> userPreferences;
  final DataState<bool> deleteAccount;
  final File? companyLogoFile;
  final DataState<bool> uploadCompanyLogo;

  VendorProfileState copyWith({
    bool? notificationsEnabled,
    DataState<VendorModel>? profileInfo,
    DataState<bool>? changePassword,
    DataState<bool>? userPreferences,
    DataState<bool>? deleteAccount,
    File? companyLogoFile,
    DataState<bool>? uploadCompanyLogo,
  }) {
    return VendorProfileState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      profileInfo: profileInfo ?? this.profileInfo,
      changePassword: changePassword ?? this.changePassword,
      userPreferences: userPreferences ?? this.userPreferences,
      deleteAccount: deleteAccount ?? this.deleteAccount,
      companyLogoFile: companyLogoFile ?? this.companyLogoFile,
      uploadCompanyLogo: uploadCompanyLogo ?? this.uploadCompanyLogo,
    );
  }

  @override
  List<Object?> get props => [
    notificationsEnabled,
    profileInfo,
    changePassword,
    userPreferences,
    deleteAccount,
    companyLogoFile,
    uploadCompanyLogo,
  ];
}
