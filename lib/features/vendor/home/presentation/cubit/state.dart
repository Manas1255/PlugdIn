import 'package:equatable/equatable.dart';
import 'package:plugdin/enums/role_type.dart';

class VendorHomeState extends Equatable {
  const VendorHomeState({
    this.selectedRoleType = RoleType.none,
  });

  final RoleType? selectedRoleType;

  VendorHomeState copyWith({
    RoleType? selectedRoleType,
  }) {
    return VendorHomeState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
  ];
}
