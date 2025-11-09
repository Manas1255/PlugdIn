import 'package:equatable/equatable.dart';
import 'package:plugdin/enums/role_type.dart';
import 'package:plugdin/enums/store_view_type.dart';

class VendorStoreState extends Equatable {
  const VendorStoreState({
    this.selectedRoleType = RoleType.none,
    this.storeViewType = StoreViewType.storeView,
  });

  final RoleType? selectedRoleType;
  final StoreViewType storeViewType;

  VendorStoreState copyWith({
    RoleType? selectedRoleType,
    StoreViewType? storeViewType,
  }) {
    return VendorStoreState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
      storeViewType: storeViewType ?? this.storeViewType,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
    storeViewType,
  ];
}
