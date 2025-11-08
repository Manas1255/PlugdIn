import 'package:bloc/bloc.dart';
import 'package:plugdin/enums/category_type.dart';
import 'package:plugdin/features/vendor/home/domain/repositories/vendor_home_repository.dart';
import 'package:plugdin/features/vendor/home/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class VendorHomeCubit extends Cubit<VendorHomeState> {
  VendorHomeCubit({required this.repository}) : super(const VendorHomeState());

  final VendorHomeRepository repository;

  Future<void> fetchAllVendors({CategoryType? filter}) async {
    emit(
      state.copyWith(
        allVendors: const DataState.loading(),
      ),
    );

    final response = await repository.getAllVendors(
      filter: filter,
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
