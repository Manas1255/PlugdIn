import 'package:bloc/bloc.dart';
import 'package:plugdin/core/enums/category_type.dart';
import 'package:plugdin/core/models/all_vendors_response_model.dart';
import 'package:plugdin/features/vendor/home/data/models/create_booking_request_model.dart';
import 'package:plugdin/features/vendor/home/domain/repositories/vendor_home_repository.dart';
import 'package:plugdin/features/vendor/home/presentation/cubit/state.dart';
import 'package:plugdin/features/vendor/store/data/models/package_model.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_packages_response_model.dart';
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

  Future<void> fetchPackageById(String packageId) async {
    emit(
      state.copyWith(
        packageDetail: const DataState.loading(),
      ),
    );

    final response = await repository.getPackageById(packageId);

    if (response.isSuccess && response.data != null) {
      emit(
        state.copyWith(
          packageDetail: DataState.loaded(data: response.data),
        ),
      );
    } else {
      emit(
        state.copyWith(
          packageDetail: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  Future<void> fetchPackageAvailability({
    required String packageId,
    required String from,
    required String to,
  }) async {
    emit(
      state.copyWith(
        packageAvailability: const DataState.loading(),
      ),
    );

    final response = await repository.getPackageAvailability(
      packageId: packageId,
      from: from,
      to: to,
    );

    if (response.isSuccess && response.data != null) {
      emit(
        state.copyWith(
          packageAvailability: DataState.loaded(data: response.data),
        ),
      );
    } else {
      emit(
        state.copyWith(
          packageAvailability: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  Future<void> createBooking(CreateBookingRequestModel request) async {
    emit(
      state.copyWith(
        createBooking: const DataState.loading(),
      ),
    );

    final response = await repository.createBooking(request);

    if (response.isSuccess && response.data != null) {
      emit(
        state.copyWith(
          createBooking: DataState.loaded(data: response.data),
        ),
      );
    } else {
      emit(
        state.copyWith(
          createBooking: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }

  void clearBookingState() {
    emit(
      state.copyWith(
        createBooking: const DataState.initial(),
      ),
    );
  }
}
