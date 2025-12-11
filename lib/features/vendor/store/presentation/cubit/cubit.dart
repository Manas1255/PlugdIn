import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plugdin/core/enums/store_view_type.dart';
import 'package:plugdin/features/vendor/store/data/models/create_package_request_model.dart';
import 'package:plugdin/features/vendor/store/data/models/features_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/package_model.dart';
import 'package:plugdin/features/vendor/store/data/models/store_media_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_features_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_packages_response_model.dart';
import 'package:plugdin/features/vendor/store/domain/repositories/vendor_store_repository.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class VendorStoreCubit extends Cubit<VendorStoreState> {
  VendorStoreCubit({required this.repository})
    : super(const VendorStoreState());

  final VendorStoreRepository repository;
  final ImagePicker _picker = ImagePicker();

  void updateSelectedStoreViewType(StoreViewType viewType) {
    emit(
      state.copyWith(
        storeViewType: viewType,
      ),
    );
  }

  Future<void> getStoreFeatures() async {
    emit(
      state.copyWith(
        allStoreFeatures: const DataState.loading(),
      ),
    );
    final response = await repository.getStoreFeatures();
    if (response.isSuccess && response.data != null) {
      emit(
        state.copyWith(
          allStoreFeatures: DataState.loaded(
            data: response.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          allStoreFeatures: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  void addFeatureToRequest(String feature) {
    final currentFeatures = List<String>.from(state.featuresRequest.features);
    final updatedFeatures = List<String>.from(currentFeatures);
    if (updatedFeatures.contains(feature)) {
      updatedFeatures.remove(feature);
    } else {
      updatedFeatures.add(feature);
    }
    final updatedRequest = state.featuresRequest.copyWith(
      features: updatedFeatures,
    );
    emit(
      state.copyWith(
        featuresRequest: updatedRequest,
      ),
    );
  }

  void initializeFeaturesFromStoreInfo() {
    final currentFeatures = state.vendorStoreInfo.data?.features ?? [];
    final updatedRequest = state.featuresRequest.copyWith(
      features: List<String>.from(currentFeatures),
    );
    emit(
      state.copyWith(
        featuresRequest: updatedRequest,
      ),
    );
  }

  Future<void> updateStoreFeatures() async {
    emit(
      state.copyWith(
        updateFeaturesState: const DataState.loading(),
      ),
    );
    final response = await repository.updateStoreFeatures(
      state.featuresRequest,
    );
    if (response.isSuccess && response.data != null) {
      // Update vendorStoreInfo with the new features from response
      final currentVendorInfo = state.vendorStoreInfo.data;
      final updatedVendorInfo = currentVendorInfo?.copyWith(
        features: response.data!.vendor.features,
      );
      
      emit(
        state.copyWith(
          updateFeaturesState: DataState.loaded(
            data: response.data!,
          ),
          vendorStoreInfo: updatedVendorInfo != null
              ? DataState.loaded(data: updatedVendorInfo)
              : state.vendorStoreInfo,
        ),
      );
    } else {
      emit(
        state.copyWith(
          updateFeaturesState: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  void resetUpdateFeaturesState() {
    emit(
      state.copyWith(
        updateFeaturesState: const DataState.initial(),
      ),
    );
  }

  Future<void> uploadStoreMedia(List<String> filePaths) async {
    emit(
      state.copyWith(
        uploadMediaState: const DataState.loading(),
      ),
    );
    final response = await repository.uploadStoreMedia(filePaths);
    if (response.isSuccess) {
      emit(
        state.copyWith(
          uploadMediaState: DataState.loaded(
            data: response.isSuccess,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          uploadMediaState: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  Future<void> pickStoreImage({
    ImageSource source = ImageSource.gallery,
  }) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );

    if (pickedFile != null) {
      addStoreImage(
        File(pickedFile.path),
      );
    }
  }

  Future<void> pickStoreImageFromCamera() async {
    await pickStoreImage(source: ImageSource.camera);
  }

  Future<void> pickStoreImageFromGallery() async {
    await pickStoreImage();
  }

  void addStoreImage(File image) {
    emit(
      state.copyWith(
        storeImageFile: image,
      ),
    );
  }

  void clearStoreImage() {
    emit(
      state.copyWith(
        storeImageFile: null,
        clearStoreImage: true,
      ),
    );
  }

  void setPostBottomSheetShown({required bool isShown}) {
    emit(
      state.copyWith(
        isPostBottomSheetShown: isShown,
      ),
    );
  }

  Future<void> getStoreMedia({int pageNumber = 1}) async {
    emit(
      state.copyWith(
        storeMedia: pageNumber == 1
            ? const DataState.loading()
            : DataState.pageLoading(
                data: state.storeMedia.data,
              ),
      ),
    );
    final response = await repository.getStoreMedia(
      pageNumber: pageNumber,
    );
    if (response.isSuccess) {
      final currentData = state.storeMedia.data;
      final updatedData = currentData != null && pageNumber > 1
          ? StoreMediaResponseModel(
              posts: [
                ...currentData.posts,
                ...response.data?.posts ?? [],
              ],
              pagination: response.data?.pagination ?? currentData.pagination,
            )
          : response.data;
      emit(
        state.copyWith(
          storeMedia: DataState.loaded(
            data: updatedData,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          storeMedia: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  Future<void> getVendorStoreInfo() async {
    emit(
      state.copyWith(
        vendorStoreInfo: const DataState.loading(),
      ),
    );
    final response = await repository.getVendorStoreInfo();
    if (response.isSuccess && response.data != null) {
      emit(
        state.copyWith(
          vendorStoreInfo: DataState.loaded(
            data: response.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          vendorStoreInfo: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  Future<void> getVendorById(String vendorId) async {
    emit(
      state.copyWith(
        otherVendorStoreInfo: const DataState.loading(),
      ),
    );
    final response = await repository.getVendorById(vendorId);
    if (response.isSuccess && response.data != null) {
      emit(
        state.copyWith(
          otherVendorStoreInfo: DataState.loaded(
            data: response.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          otherVendorStoreInfo: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  Future<void> getVendorPackages({int pageNumber = 1}) async {
    emit(
      state.copyWith(
        vendorPackages: pageNumber == 1
            ? const DataState.loading()
            : DataState.pageLoading(
                data: state.vendorPackages.data,
              ),
      ),
    );

    final response = await repository.getVendorPackages(
      pageNumber: pageNumber,
    );

    if (response.isSuccess) {
      final currentData = state.vendorPackages.data;
      final updatedData = currentData != null && pageNumber > 1
          ? VendorPackagesResponseModel(
              packages: [
                ...currentData.packages,
                ...response.data?.packages ?? [],
              ],
              pagination: response.data?.pagination ?? currentData.pagination,
            )
          : response.data;

      emit(
        state.copyWith(
          vendorPackages: DataState.loaded(
            data: updatedData,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          vendorPackages: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  Future<void> createPackage(CreatePackageRequestModel package) async {
    emit(
      state.copyWith(
        createPackageState: const DataState.loading(),
      ),
    );
    final response = await repository.createPackage(package);
    if (response.isSuccess && response.data != null) {
      final updatedPackages = VendorPackagesResponseModel(
        packages: [
          response.data!.package,
          ...state.vendorPackages.data?.packages ?? [],
        ],
        pagination: state.vendorPackages.data?.pagination,
      );

      emit(
        state.copyWith(
          createPackageState: DataState.loaded(
            data: response.data,
          ),
          vendorPackages: DataState.loaded(
            data: updatedPackages,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          createPackageState: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  void resetCreatePackageState() {
    emit(
      state.copyWith(
        createPackageState: const DataState.initial(),
      ),
    );
  }
}
