import 'package:bloc/bloc.dart';
import 'package:plugdin/enums/category_type.dart';
import 'package:plugdin/features/customer/home/domain/repositories/customer_home_repository.dart';
import 'package:plugdin/features/customer/home/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class CustomerHomeCubit extends Cubit<CustomerHomeState> {
  CustomerHomeCubit({required this.repository})
    : super(const CustomerHomeState());

  final CustomerHomeRepository repository;

  Future<void> fetchAllVendors({CategoryType? filter}) async {
    final selectedFilter = filter ?? state.selectedFilter;
    final categoryFilter = selectedFilter == CategoryType.all
        ? null
        : selectedFilter;
    emit(
      state.copyWith(
        allVendors: const DataState.loading(),
      ),
    );

    final response = await repository.getAllVendors(
      filter: categoryFilter,
    );

    if (response.isSuccess && response.data != null) {
      emit(
        state.copyWith(
          allVendors: DataState.loaded(
            data: response.data,
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
