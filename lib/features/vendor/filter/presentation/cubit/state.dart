import 'package:equatable/equatable.dart';
import 'package:plugdin/core/enums/filter_view_type.dart';
import 'package:plugdin/core/enums/role_type.dart';

class VendorFilterState extends Equatable {
  const VendorFilterState({
    this.selectedRoleType = RoleType.none,
    this.viewType = FilterViewType.normalDisplayView,
  });

  final RoleType? selectedRoleType;
  final FilterViewType viewType;

  VendorFilterState copyWith({
    RoleType? selectedRoleType,
    FilterViewType? viewType,
  }) {
    return VendorFilterState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
      viewType: viewType ?? this.viewType,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
    viewType,
  ];
}
