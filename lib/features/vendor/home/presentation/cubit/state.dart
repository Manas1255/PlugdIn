import 'package:equatable/equatable.dart';
import 'package:plugdin/core/models/all_vendors_response_model.dart';
import 'package:plugdin/enums/role_type.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class VendorHomeState extends Equatable {
  const VendorHomeState({
    this.selectedRoleType = RoleType.none,
    this.allVendors = const DataState.initial(),
  });

  final RoleType? selectedRoleType;
  final DataState<AllVendorsResponseModel> allVendors;

  VendorHomeState copyWith({
    RoleType? selectedRoleType,
    DataState<AllVendorsResponseModel>? allVendors,
  }) {
    return VendorHomeState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
      allVendors: allVendors ?? this.allVendors,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
    allVendors,
  ];
}
