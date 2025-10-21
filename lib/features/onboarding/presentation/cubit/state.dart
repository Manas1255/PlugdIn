import 'package:equatable/equatable.dart';
import 'package:plugdin/enums/role_type.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    this.selectedRoleType = RoleType.none,
    this.emailSignUp = const DataState.initial(),
    this.emailLogin = const DataState.initial(),
    this.passwordResetCode = const DataState.initial(),
  });

  final RoleType? selectedRoleType;
  final DataState<bool> emailSignUp;
  final DataState<bool> emailLogin;
  final DataState<bool> passwordResetCode;

  OnboardingState copyWith({
    RoleType? selectedRoleType,
    DataState<bool>? emailSignUp,
    DataState<bool>? emailLogin,
    DataState<bool>? passwordResetCode,
  }) {
    return OnboardingState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
      emailSignUp: emailSignUp ?? this.emailSignUp,
      emailLogin: emailLogin ?? this.emailLogin,
      passwordResetCode: passwordResetCode ?? this.passwordResetCode,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
    emailSignUp,
    emailLogin,
    passwordResetCode,
  ];
}
