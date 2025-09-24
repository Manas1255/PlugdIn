import 'package:equatable/equatable.dart';
import 'package:plugdin/enums/role_type.dart';

class OnboardingFlowState extends Equatable {
  const OnboardingFlowState({
    this.currentPage = 0,
    this.selectedRoleType,
  });

  final int currentPage;
  final RoleType? selectedRoleType;

  OnboardingFlowState copyWith({
    int? currentPage,
    RoleType? selectedRoleType,
  }) {
    return OnboardingFlowState(
      currentPage: currentPage ?? this.currentPage,
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
    );
  }

  @override
  List<Object?> get props => [
    currentPage,
    selectedRoleType,
  ];
}
