import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:plugdin/core/enums/role_type.dart';
import 'package:plugdin/core/enums/store_view_type.dart';
import 'package:plugdin/features/vendor/store/data/models/features_request_model.dart';
import 'package:plugdin/features/vendor/store/data/models/features_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/package_model.dart';
import 'package:plugdin/features/vendor/store/data/models/store_media_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_features_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_store_info_model.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class VendorStoreState extends Equatable {
  const VendorStoreState({
    this.selectedRoleType = RoleType.none,
    this.storeViewType = StoreViewType.storeView,
    this.allStoreFeatures = const DataState.initial(),
    this.featuresRequest = const FeaturesRequestModel.empty(),
    this.updateFeaturesState = const DataState.initial(),
    this.uploadMediaState = const DataState.initial(),
    this.storeImageFile,
    this.clearStoreImage = false,
    this.isPostBottomSheetShown = false,
    this.storeMedia = const DataState.initial(),
    this.vendorStoreInfo = const DataState.initial(),
    this.otherVendorStoreInfo = const DataState.initial(),
    this.createPackageState = const DataState.initial(),
  });

  final RoleType? selectedRoleType;
  final StoreViewType storeViewType;
  final DataState<FeaturesResponseModel> allStoreFeatures;
  final FeaturesRequestModel featuresRequest;
  final DataState<VendorFeaturesResponseModel> updateFeaturesState;
  final DataState<bool> uploadMediaState;
  final File? storeImageFile;
  final bool clearStoreImage;
  final bool isPostBottomSheetShown;
  final DataState<StoreMediaResponseModel> storeMedia;
  final DataState<VendorStoreInfoModel> vendorStoreInfo;
  final DataState<VendorStoreInfoModel> otherVendorStoreInfo;
  final DataState<CreatePackageResponseModel> createPackageState;

  VendorStoreState copyWith({
    RoleType? selectedRoleType,
    StoreViewType? storeViewType,
    DataState<FeaturesResponseModel>? allStoreFeatures,
    FeaturesRequestModel? featuresRequest,
    DataState<VendorFeaturesResponseModel>? updateFeaturesState,
    DataState<bool>? uploadMediaState,
    File? storeImageFile,
    bool? clearStoreImage,
    bool? isPostBottomSheetShown,
    DataState<StoreMediaResponseModel>? storeMedia,
    DataState<VendorStoreInfoModel>? vendorStoreInfo,
    DataState<VendorStoreInfoModel>? otherVendorStoreInfo,
    DataState<CreatePackageResponseModel>? createPackageState,
  }) {
    // If clearStoreImage is being set to true, also clear the storeImageFile
    final bool willClearImage = clearStoreImage == true;
    final File? finalStoreImageFile = willClearImage
        ? null
        : (storeImageFile ?? this.storeImageFile);

    return VendorStoreState(
      selectedRoleType: selectedRoleType ?? this.selectedRoleType,
      storeViewType: storeViewType ?? this.storeViewType,
      allStoreFeatures: allStoreFeatures ?? this.allStoreFeatures,
      featuresRequest: featuresRequest ?? this.featuresRequest,
      updateFeaturesState: updateFeaturesState ?? this.updateFeaturesState,
      uploadMediaState: uploadMediaState ?? this.uploadMediaState,
      storeImageFile: finalStoreImageFile,
      clearStoreImage: clearStoreImage ?? this.clearStoreImage,
      isPostBottomSheetShown:
          isPostBottomSheetShown ?? this.isPostBottomSheetShown,
      storeMedia: storeMedia ?? this.storeMedia,
      vendorStoreInfo: vendorStoreInfo ?? this.vendorStoreInfo,
      otherVendorStoreInfo: otherVendorStoreInfo ?? this.otherVendorStoreInfo,
      createPackageState: createPackageState ?? this.createPackageState,
    );
  }

  @override
  List<Object?> get props => [
    selectedRoleType,
    storeViewType,
    allStoreFeatures,
    featuresRequest,
    updateFeaturesState,
    uploadMediaState,
    storeImageFile,
    clearStoreImage,
    isPostBottomSheetShown,
    storeMedia,
    vendorStoreInfo,
    otherVendorStoreInfo,
    createPackageState,
  ];
}
