import 'package:bloc/bloc.dart';
import 'package:plugdin/core/enums/store_view_type.dart';
import 'package:plugdin/features/customer/store/domain/repositories/customer_store_repository.dart';
import 'package:plugdin/features/customer/store/presentation/cubit/state.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_packages_response_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_reviews_response_model.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class CustomerStoreCubit extends Cubit<CustomerStoreState> {
  CustomerStoreCubit({required this.repository})
    : super(const CustomerStoreState());

  final CustomerStoreRepository repository;

  void updateSelectedStoreViewType(StoreViewType viewType) {
    emit(
      state.copyWith(
        storeViewType: viewType,
      ),
    );
  }

  Future<void> getVendorById(String vendorId) async {
    emit(
      state.copyWith(
        vendorStoreInfo: const DataState.loading(),
      ),
    );
    final response = await repository.getVendorById(vendorId);
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

  Future<void> getVendorReviewsById({
    required String vendorId,
    int pageNumber = 1,
  }) async {
    emit(
      state.copyWith(
        vendorReviews: pageNumber == 1
            ? const DataState.loading()
            : DataState.pageLoading(
                data: state.vendorReviews.data,
              ),
      ),
    );
    final response = await repository.getVendorReviewsById(
      vendorId: vendorId,
      pageNumber: pageNumber,
    );
    if (response.isSuccess) {
      final currentData = state.vendorReviews.data;
      final updatedData = currentData != null && pageNumber > 1
          ? VendorReviewsResponseModel(
              reviews: [
                ...currentData.reviews,
                ...response.data?.reviews ?? [],
              ],
              pagination: response.data?.pagination ?? currentData.pagination,
            )
          : response.data;

      emit(
        state.copyWith(
          vendorReviews: DataState.loaded(
            data: updatedData,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          vendorReviews: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  Future<void> getVendorPackagesById({
    required String vendorId,
    int pageNumber = 1,
  }) async {
    emit(
      state.copyWith(
        vendorPackages: pageNumber == 1
            ? const DataState.loading()
            : DataState.pageLoading(
                data: state.vendorPackages.data,
              ),
      ),
    );

    final response = await repository.getVendorPackagesById(
      vendorId: vendorId,
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
}
