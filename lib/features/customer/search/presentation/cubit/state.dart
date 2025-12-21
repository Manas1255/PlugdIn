import 'package:equatable/equatable.dart';
import 'package:plugdin/core/enums/role_type.dart';

class CustomerSearchState extends Equatable {
  const CustomerSearchState({
    this.selectedRoleType = RoleType.none,
  });

  final RoleType? selectedRoleType;

  CustomerSearchState copyWith({
    RoleType? selectedRoleType,
  }) {
    return CustomerSearchState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
  ];
}

