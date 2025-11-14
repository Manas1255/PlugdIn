import 'package:bloc/bloc.dart';
import 'package:plugdin/core/enums/store_view_type.dart';
import 'package:plugdin/features/vendor/store/domain/repositories/vendor_store_repository.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class VendorStoreCubit extends Cubit<VendorStoreState> {
  VendorStoreCubit({required this.repository})
    : super(const VendorStoreState());

  final VendorStoreRepository repository;

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
}
