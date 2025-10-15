import 'package:equatable/equatable.dart';
import 'package:plugdin/enums/role_type.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    this.selectedRoleType = RoleType.none,
    this.emailSignUp = const DataState.initial(),
    this.emailLogin = const DataState.initial(),
    this.passwordResetCode = const DataState.initial(),
    this.resetPassword = const DataState.initial(),
    this.passwordResetEmail = '',
    this.verifyPasswordResetCode = const DataState.initial(),
    this.googleSignIn = const DataState.initial(),
    this.currentPage = 0,
  });

  final RoleType? selectedRoleType;
  final DataState<bool> emailSignUp;
  final DataState<bool> emailLogin;
  final DataState<bool> passwordResetCode;
  final DataState<bool> resetPassword;
  final String passwordResetEmail;
  final DataState<bool> verifyPasswordResetCode;
  final DataState<bool> googleSignIn;
  final int currentPage;

  OnboardingState copyWith({
    RoleType? selectedRoleType,
    DataState<bool>? emailSignUp,
    DataState<bool>? emailLogin,
    DataState<bool>? passwordResetCode,
    String? passwordResetEmail,
    DataState<bool>? verifyPasswordResetCode,
    DataState<bool>? resetPassword,
    DataState<bool>? googleSignIn,
    int? currentPage,
  }) {
    return OnboardingState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
      emailSignUp: emailSignUp ?? this.emailSignUp,
      emailLogin: emailLogin ?? this.emailLogin,
      passwordResetCode: passwordResetCode ?? this.passwordResetCode,
      passwordResetEmail: passwordResetEmail ?? this.passwordResetEmail,
      resetPassword: resetPassword ?? this.resetPassword,
      verifyPasswordResetCode:
          verifyPasswordResetCode ?? this.verifyPasswordResetCode,
      googleSignIn: googleSignIn ?? this.googleSignIn,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
    emailSignUp,
    emailLogin,
    passwordResetCode,
    passwordResetEmail,
    resetPassword,
    verifyPasswordResetCode,
    googleSignIn,
    currentPage,
  ];
}
