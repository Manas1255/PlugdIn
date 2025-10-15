import 'package:equatable/equatable.dart';
import 'package:plugdin/enums/category_type.dart';
import 'package:plugdin/enums/city.dart';
import 'package:plugdin/enums/role_type.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    this.selectedRoleType = RoleType.none,
    this.customerEmailSignUp = const DataState.initial(),
    this.emailLogin = const DataState.initial(),
    this.passwordResetCode = const DataState.initial(),
    this.resetPassword = const DataState.initial(),
    this.passwordResetEmail = '',
    this.verifyPasswordResetCode = const DataState.initial(),
    this.googleSignIn = const DataState.initial(),
    this.currentPage = 0,
    this.selectedCity,
    this.selectedPrimaryCategory,
  });

  final RoleType? selectedRoleType;
  final DataState<bool> customerEmailSignUp;
  final DataState<bool> emailLogin;
  final DataState<bool> passwordResetCode;
  final DataState<bool> resetPassword;
  final String passwordResetEmail;
  final DataState<bool> verifyPasswordResetCode;
  final DataState<bool> googleSignIn;
  final int currentPage;
  final City? selectedCity;
  final CategoryType? selectedPrimaryCategory;

  OnboardingState copyWith({
    RoleType? selectedRoleType,
    DataState<bool>? customerEmailSignUp,
    DataState<bool>? emailLogin,
    DataState<bool>? passwordResetCode,
    String? passwordResetEmail,
    DataState<bool>? verifyPasswordResetCode,
    DataState<bool>? resetPassword,
    DataState<bool>? googleSignIn,
    int? currentPage,
    City? selectedCity,
    CategoryType? selectedPrimaryCategory,
  }) {
    return OnboardingState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
      customerEmailSignUp: customerEmailSignUp ?? this.customerEmailSignUp,
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
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
    customerEmailSignUp,
    emailLogin,
    passwordResetCode,
    passwordResetEmail,
    resetPassword,
    verifyPasswordResetCode,
    googleSignIn,
    currentPage,
    selectedCity,
    selectedPrimaryCategory,
  ];
}
