import 'package:equatable/equatable.dart';
import 'package:plugdin/core/models/all_vendors_response_model.dart';
import 'package:plugdin/enums/category_type.dart';
import 'package:plugdin/enums/role_type.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class VendorHomeState extends Equatable {
  const VendorHomeState({
    this.selectedRoleType = RoleType.none,
    this.allVendors = const DataState.initial(),
    this.selectedFilter = CategoryType.all,
  });

  final RoleType? selectedRoleType;
  final DataState<AllVendorsResponseModel> allVendors;
  final CategoryType selectedFilter;

  VendorHomeState copyWith({
    RoleType? selectedRoleType,
    DataState<AllVendorsResponseModel>? allVendors,
    CategoryType? selectedFilter,
  }) {
    return VendorHomeState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
      allVendors: allVendors ?? this.allVendors,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
    allVendors,
    selectedFilter,
  ];
}
