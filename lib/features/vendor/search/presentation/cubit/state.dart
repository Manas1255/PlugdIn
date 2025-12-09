import 'package:equatable/equatable.dart';
import 'package:plugdin/core/enums/role_type.dart';

class VendorSearchState extends Equatable {
  const VendorSearchState({
    this.selectedRoleType = RoleType.none,
  });

  final RoleType? selectedRoleType;

  VendorSearchState copyWith({
    RoleType? selectedRoleType,
  }) {
    return VendorSearchState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
  ];
}
