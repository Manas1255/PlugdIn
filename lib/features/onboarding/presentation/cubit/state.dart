import 'package:equatable/equatable.dart';
import 'package:plugdin/enums/role_type.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    this.selectedRoleType = RoleType.none,
    this.emailSignUp = const DataState.initial(),
    this.emailLogin = const DataState.initial(),
    this.passwordResetCode = const DataState.initial(),
    this.newPassword = const DataState.initial(),
    this.passwordResetEmail = '',
    this.verifyPasswordResetCode = const DataState.initial(),
  });

  final RoleType? selectedRoleType;
  final DataState<bool> emailSignUp;
  final DataState<bool> emailLogin;
  final DataState<bool> passwordResetCode;
  final DataState<bool> newPassword;
  final String passwordResetEmail;
  final DataState<bool> verifyPasswordResetCode;

  OnboardingState copyWith({
    RoleType? selectedRoleType,
    DataState<bool>? emailSignUp,
    DataState<bool>? emailLogin,
    DataState<bool>? passwordResetCode,
    String? passwordResetEmail,
    DataState<bool>? verifyPasswordResetCode,
    DataState<bool>? newPassword,
  }) {
    return OnboardingState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
      emailSignUp: emailSignUp ?? this.emailSignUp,
      emailLogin: emailLogin ?? this.emailLogin,
      passwordResetCode: passwordResetCode ?? this.passwordResetCode,
      passwordResetEmail: passwordResetEmail ?? this.passwordResetEmail,
      newPassword: newPassword ?? this.newPassword,
      verifyPasswordResetCode:
          verifyPasswordResetCode ?? this.verifyPasswordResetCode,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
    emailSignUp,
    emailLogin,
    passwordResetCode,
    passwordResetEmail,
    newPassword,
    verifyPasswordResetCode,
  ];
}
