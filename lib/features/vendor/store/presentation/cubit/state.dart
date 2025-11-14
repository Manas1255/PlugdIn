import 'package:equatable/equatable.dart';
import 'package:plugdin/core/enums/role_type.dart';
import 'package:plugdin/core/enums/store_view_type.dart';
import 'package:plugdin/features/vendor/store/data/models/features_request_model.dart';
import 'package:plugdin/features/vendor/store/data/models/features_response_model.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class VendorStoreState extends Equatable {
  const VendorStoreState({
    this.selectedRoleType = RoleType.none,
    this.storeViewType = StoreViewType.storeView,
    this.allStoreFeatures = const DataState.initial(),
    this.featuresRequest = const FeaturesRequestModel.empty(),
    this.updateFeaturesState = const DataState.initial(),
  });

  final RoleType? selectedRoleType;
  final StoreViewType storeViewType;
  final DataState<FeaturesResponseModel> allStoreFeatures;
  final FeaturesRequestModel featuresRequest;
  final DataState<bool> updateFeaturesState;

  VendorStoreState copyWith({
    RoleType? selectedRoleType,
    StoreViewType? storeViewType,
    DataState<FeaturesResponseModel>? allStoreFeatures,
    FeaturesRequestModel? featuresRequest,
    DataState<bool>? updateFeaturesState,
  }) {
    return VendorStoreState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
      storeViewType: storeViewType ?? this.storeViewType,
      allStoreFeatures: allStoreFeatures ?? this.allStoreFeatures,
      featuresRequest: featuresRequest ?? this.featuresRequest,
      updateFeaturesState: updateFeaturesState ?? this.updateFeaturesState,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
    storeViewType,
    allStoreFeatures,
    featuresRequest,
    updateFeaturesState,
  ];
}
