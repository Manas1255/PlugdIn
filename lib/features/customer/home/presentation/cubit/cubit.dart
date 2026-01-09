import 'package:bloc/bloc.dart';
import 'package:plugdin/core/enums/category_type.dart';
import 'package:plugdin/core/models/all_vendors_response_model.dart';
import 'package:plugdin/features/customer/home/domain/repositories/customer_home_repository.dart';
import 'package:plugdin/features/customer/home/presentation/cubit/state.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_packages_response_model.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class CustomerHomeCubit extends Cubit<CustomerHomeState> {
  CustomerHomeCubit({required this.repository})
    : super(const CustomerHomeState());

  final CustomerHomeRepository repository;

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
      pageNumber: pageNumber,
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

  Future<void> fetchAllPackages({int pageNumber = 1}) async {
    emit(
      state.copyWith(
        allPackages: pageNumber == 1
            ? const DataState.loading()
            : DataState.pageLoading(
                data: state.allPackages.data,
              ),
      ),
    );

    final response = await repository.getAllPackages(
      pageNumber: pageNumber,
    );

    if (response.isSuccess) {
      final currentData = state.allPackages.data;
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
          allPackages: DataState.loaded(
            data: updatedData,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          allPackages: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }
}
