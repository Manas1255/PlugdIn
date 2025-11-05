import 'package:equatable/equatable.dart';
import 'package:plugdin/enums/role_type.dart';

class CustomerHomeState extends Equatable {
  const CustomerHomeState({
    this.selectedRoleType = RoleType.none,
  });

  final RoleType? selectedRoleType;

  CustomerHomeState copyWith({
    RoleType? selectedRoleType,
  }) {
    return CustomerHomeState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
  ];
}
