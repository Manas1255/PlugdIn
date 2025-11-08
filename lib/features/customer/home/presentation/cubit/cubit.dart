import 'package:bloc/bloc.dart';
import 'package:plugdin/features/customer/home/domain/repositories/customer_home_repository.dart';
import 'package:plugdin/features/customer/home/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class CustomerHomeCubit extends Cubit<CustomerHomeState> {
  CustomerHomeCubit({required this.repository})
    : super(const CustomerHomeState());

  final CustomerHomeRepository repository;

  Future<void> fetchAllVendors() async {
    emit(
      state.copyWith(
        allVendors: const DataState.loading(),
      ),
    );

    final response = await repository.getAllVendors();

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
}
