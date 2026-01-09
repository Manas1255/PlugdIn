import 'package:equatable/equatable.dart';
import 'package:plugdin/core/enums/store_view_type.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_packages_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_reviews_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_store_info_model.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class CustomerStoreState extends Equatable {
  const CustomerStoreState({
    this.storeViewType = StoreViewType.storeView,
    this.vendorStoreInfo = const DataState.initial(),
    this.vendorReviews = const DataState.initial(),
    this.vendorPackages = const DataState.initial(),
  });

  final StoreViewType storeViewType;
  final DataState<VendorStoreInfoModel> vendorStoreInfo;
  final DataState<VendorReviewsResponseModel> vendorReviews;
  final DataState<VendorPackagesResponseModel> vendorPackages;

  CustomerStoreState copyWith({
    StoreViewType? storeViewType,
    DataState<VendorStoreInfoModel>? vendorStoreInfo,
    DataState<VendorReviewsResponseModel>? vendorReviews,
    DataState<VendorPackagesResponseModel>? vendorPackages,
  }) {
    return CustomerStoreState(
      storeViewType: storeViewType ?? this.storeViewType,
      vendorStoreInfo: vendorStoreInfo ?? this.vendorStoreInfo,
      vendorReviews: vendorReviews ?? this.vendorReviews,
      vendorPackages: vendorPackages ?? this.vendorPackages,
    );
  }

  @override
  List<Object?> get props => [
    storeViewType,
    vendorStoreInfo,
    vendorReviews,
    vendorPackages,
  ];
}
