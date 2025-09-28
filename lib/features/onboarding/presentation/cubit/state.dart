import 'package:equatable/equatable.dart';
import 'package:plugdin/enums/role_type.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    this.selectedRoleType = RoleType.customer,
    this.emailSignUp = const DataState.initial(),
    this.emailLogin = const DataState.initial(),
  });

  final RoleType? selectedRoleType;
  final DataState<bool> emailSignUp;
  final DataState<bool> emailLogin;

  OnboardingState copyWith({
    RoleType? selectedRoleType,
    DataState<bool>? emailSignUp,
    DataState<bool>? emailLogin,
  }) {
    return OnboardingState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
      emailSignUp: emailSignUp ?? this.emailSignUp,
      emailLogin: emailLogin ?? this.emailLogin,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
    emailSignUp,
    emailLogin,
  ];
}
