import 'package:equatable/equatable.dart';
import 'package:plugdin/enums/role_type.dart';

class HomeState extends Equatable {
  const HomeState({
    this.selectedRoleType = RoleType.none,
  });

  final RoleType? selectedRoleType;

  HomeState copyWith({
    RoleType? selectedRoleType,
  }) {
    return HomeState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
  ];
}
