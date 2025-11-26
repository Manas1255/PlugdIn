import 'package:equatable/equatable.dart';
import 'package:plugdin/core/enums/role_type.dart';

class VendorNotificationsState extends Equatable {
  const VendorNotificationsState({
    this.selectedRoleType = RoleType.none,
  });

  final RoleType? selectedRoleType;

  VendorNotificationsState copyWith({
    RoleType? selectedRoleType,
  }) {
    return VendorNotificationsState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
  ];
}
