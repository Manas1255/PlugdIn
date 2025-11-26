import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plugdin/core/enums/store_view_type.dart';
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
    final updatedFeatures = List<String>.from(state.featuresRequest.features)
      ..add(feature);
    final updatedRequest = state.featuresRequest.copyWith(
      features: updatedFeatures,
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
    if (response.isSuccess) {
      emit(
        state.copyWith(
          updateFeaturesState: DataState.loaded(
            data: response.isSuccess,
          ),
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

  void setPostBottomSheetShown(bool isShown) {
    emit(
      state.copyWith(
        isPostBottomSheetShown: isShown,
      ),
    );
  }

  Future<void> getStoreMedia({int pageNumber = 1}) async {
    emit(
      state.copyWith(
        storeMedia: const DataState.loading(),
      ),
    );
    final response = await repository.getStoreMedia(
      pageNumber: pageNumber,
    );
    if (response.isSuccess && response.data != null) {
      emit(
        state.copyWith(
          storeMedia: DataState.loaded(
            data: response.data,
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
}
