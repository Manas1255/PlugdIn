import 'package:equatable/equatable.dart';
import 'package:plugdin/core/enums/category_type.dart';
import 'package:plugdin/core/enums/role_type.dart';
import 'package:plugdin/core/models/all_vendors_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/package_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_packages_response_model.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class VendorHomeState extends Equatable {
  const VendorHomeState({
    this.selectedRoleType = RoleType.none,
    this.allVendors = const DataState.initial(),
    this.selectedFilter = CategoryType.all,
    this.allPackages = const DataState.initial(),
    this.packageDetail = const DataState.initial(),
  });

  final RoleType? selectedRoleType;
  final DataState<AllVendorsResponseModel> allVendors;
  final CategoryType selectedFilter;
  final DataState<VendorPackagesResponseModel> allPackages;
  final DataState<PackageModel> packageDetail;

  VendorHomeState copyWith({
    RoleType? selectedRoleType,
    DataState<AllVendorsResponseModel>? allVendors,
    CategoryType? selectedFilter,
    DataState<VendorPackagesResponseModel>? allPackages,
    DataState<PackageModel>? packageDetail,
  }) {
    return VendorHomeState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
      allVendors: allVendors ?? this.allVendors,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      allPackages: allPackages ?? this.allPackages,
      packageDetail: packageDetail ?? this.packageDetail,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
    allVendors,
    selectedFilter,
    allPackages,
    packageDetail,
  ];
}
