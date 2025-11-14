import 'package:bloc/bloc.dart';
import 'package:plugdin/core/enums/category_type.dart';
import 'package:plugdin/core/models/all_vendors_response_model.dart';
import 'package:plugdin/features/vendor/home/domain/repositories/vendor_home_repository.dart';
import 'package:plugdin/features/vendor/home/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class VendorHomeCubit extends Cubit<VendorHomeState> {
  VendorHomeCubit({required this.repository}) : super(const VendorHomeState());

  final VendorHomeRepository repository;

  Future<void> fetchAllVendors({
    CategoryType? filter,
    int pageNumber = 1,
  }) async {
    final selectedFilter = filter ?? state.selectedFilter;
    final categoryFilter = selectedFilter == CategoryType.all
        ? null
        : selectedFilter;

    emit(
      state.copyWith(
        allVendors: pageNumber == 1
            ? const DataState.loading()
            : DataState.pageLoading(
                data: state.allVendors.data,
              ),
      ),
    );

    final response = await repository.getAllVendors(
      filter: categoryFilter,
    );

    if (response.isSuccess && response.data != null) {
      final currentData = state.allVendors.data;
      final updatedData = currentData != null && pageNumber > 1
          ? AllVendorsResponseModel(
              vendors: [
                ...currentData.vendors,
                ...response.data?.vendors ?? [],
              ],
              pagination: response.data?.pagination ?? currentData.pagination,
            )
          : response.data;

      emit(
        state.copyWith(
          allVendors: DataState.loaded(
            data: updatedData,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          allVendors: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  void updateSelectedFilter({required CategoryType filter}) {
    emit(
      state.copyWith(
        selectedFilter: filter,
      ),
    );
  }
}
