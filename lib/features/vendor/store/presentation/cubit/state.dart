import 'package:equatable/equatable.dart';
import 'package:plugdin/core/enums/role_type.dart';
import 'package:plugdin/core/enums/store_view_type.dart';
import 'package:plugdin/features/vendor/store/data/models/features_response_model.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class VendorStoreState extends Equatable {
  const VendorStoreState({
    this.selectedRoleType = RoleType.none,
    this.storeViewType = StoreViewType.storeView,
    this.allStoreFeatures = const DataState.initial(),
  });

  final RoleType? selectedRoleType;
  final StoreViewType storeViewType;
  final DataState<FeaturesResponseModel> allStoreFeatures;

  VendorStoreState copyWith({
    RoleType? selectedRoleType,
    StoreViewType? storeViewType,
    DataState<FeaturesResponseModel>? allStoreFeatures,
  }) {
    return VendorStoreState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
      storeViewType: storeViewType ?? this.storeViewType,
      allStoreFeatures: allStoreFeatures ?? this.allStoreFeatures,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
    storeViewType,
    allStoreFeatures,
  ];
}
