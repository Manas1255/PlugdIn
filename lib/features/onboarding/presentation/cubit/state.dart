import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:plugdin/core/enums/category_type.dart';
import 'package:plugdin/core/enums/city.dart';
import 'package:plugdin/core/enums/role_type.dart';
import 'package:plugdin/core/models/customer_model.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    this.selectedRoleType = RoleType.none,
    this.customerEmailSignUp = const DataState.initial(),
    this.vendorEmailSignUp = const DataState.initial(),
    this.emailLogin = const DataState.initial(),
    this.passwordResetCode = const DataState.initial(),
    this.resetPassword = const DataState.initial(),
    this.passwordResetEmail = '',
    this.verifyPasswordResetCode = const DataState.initial(),
    this.googleSignIn = const DataState.initial(),
    this.currentPage = 0,
    this.selectedCity,
    this.selectedPrimaryCategory,
    this.selectedAdditionalCategory,
    this.profileImageFile,
    this.uploadProfileImage = const DataState.initial(),
  });

  final RoleType? selectedRoleType;
  final DataState<CustomerModel?> customerEmailSignUp;
  final DataState<bool> vendorEmailSignUp;
  final DataState<bool> emailLogin;
  final DataState<bool> passwordResetCode;
  final DataState<bool> resetPassword;
  final String passwordResetEmail;
  final DataState<bool> verifyPasswordResetCode;
  final DataState<bool> googleSignIn;
  final int currentPage;
  final City? selectedCity;
  final CategoryType? selectedPrimaryCategory;
  final CategoryType? selectedAdditionalCategory;
  final File? profileImageFile;
  final DataState<bool> uploadProfileImage;

  OnboardingState copyWith({
    RoleType? selectedRoleType,
    DataState<CustomerModel?>? customerEmailSignUp,
    DataState<bool>? vendorEmailSignUp,
    DataState<bool>? emailLogin,
    DataState<bool>? passwordResetCode,
    String? passwordResetEmail,
    DataState<bool>? verifyPasswordResetCode,
    DataState<bool>? resetPassword,
    DataState<bool>? googleSignIn,
    int? currentPage,
    City? selectedCity,
    CategoryType? selectedPrimaryCategory,
    CategoryType? selectedAdditionalCategory,
    File? profileImageFile,
    DataState<bool>? uploadProfileImage,
  }) {
    return OnboardingState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
      customerEmailSignUp: customerEmailSignUp ?? this.customerEmailSignUp,
      vendorEmailSignUp: vendorEmailSignUp ?? this.vendorEmailSignUp,
      emailLogin: emailLogin ?? this.emailLogin,
      passwordResetCode: passwordResetCode ?? this.passwordResetCode,
      passwordResetEmail: passwordResetEmail ?? this.passwordResetEmail,
      resetPassword: resetPassword ?? this.resetPassword,
      verifyPasswordResetCode:
          verifyPasswordResetCode ?? this.verifyPasswordResetCode,
      googleSignIn: googleSignIn ?? this.googleSignIn,
      currentPage: currentPage ?? this.currentPage,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedPrimaryCategory:
          selectedPrimaryCategory ?? this.selectedPrimaryCategory,
      selectedAdditionalCategory:
          selectedAdditionalCategory ?? this.selectedAdditionalCategory,
      profileImageFile: profileImageFile ?? this.profileImageFile,
      uploadProfileImage: uploadProfileImage ?? this.uploadProfileImage,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
    customerEmailSignUp,
    vendorEmailSignUp,
    emailLogin,
    passwordResetCode,
    passwordResetEmail,
    resetPassword,
    verifyPasswordResetCode,
    googleSignIn,
    currentPage,
    selectedCity,
    selectedPrimaryCategory,
    selectedAdditionalCategory,
    profileImageFile,
    uploadProfileImage,
  ];
}
