import 'package:equatable/equatable.dart';
import 'package:plugdin/core/enums/filter_view_type.dart';
import 'package:plugdin/core/enums/role_type.dart';

class VendorFilterState extends Equatable {
  const VendorFilterState({
    this.selectedRoleType = RoleType.none,
    this.viewType = FilterViewType.normalDisplayView,
    this.minCapacity = 0,
    this.maxCapacity = 1000000,
  });

  final RoleType? selectedRoleType;
  final FilterViewType viewType;
  final int minCapacity;
  final int maxCapacity;

  VendorFilterState copyWith({
    RoleType? selectedRoleType,
    FilterViewType? viewType,
    int? minCapacity,
    int? maxCapacity,
  }) {
    return VendorFilterState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
      viewType: viewType ?? this.viewType,
      minCapacity: minCapacity ?? this.minCapacity,
      maxCapacity: maxCapacity ?? this.maxCapacity,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
    viewType,
    minCapacity,
    maxCapacity,
  ];
}
