import 'package:equatable/equatable.dart';
import 'package:plugdin/core/models/all_vendors_response_model.dart';
import 'package:plugdin/enums/role_type.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class CustomerHomeState extends Equatable {
  const CustomerHomeState({
    this.selectedRoleType = RoleType.none,
    this.allVendors = const DataState.initial(),
  });

  final RoleType? selectedRoleType;
  final DataState<AllVendorsResponseModel> allVendors;

  CustomerHomeState copyWith({
    RoleType? selectedRoleType,
    DataState<AllVendorsResponseModel>? allVendors,
  }) {
    return CustomerHomeState(
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
