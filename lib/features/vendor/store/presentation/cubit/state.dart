import 'package:equatable/equatable.dart';
import 'package:plugdin/enums/role_type.dart';

class VendorStoreState extends Equatable {
  const VendorStoreState({
    this.selectedRoleType = RoleType.none,
  });

  final RoleType? selectedRoleType;

  VendorStoreState copyWith({
    RoleType? selectedRoleType,
  }) {
    return VendorStoreState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
  ];
}
