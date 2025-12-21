import 'package:bloc/bloc.dart';
import 'package:plugdin/core/enums/city.dart';
import 'package:plugdin/core/enums/filter_view_type.dart';
import 'package:plugdin/features/customer/filter/domain/repositories/customer_filter_repository.dart';
import 'package:plugdin/features/customer/filter/presentation/cubit/state.dart';

class CustomerFilterCubit extends Cubit<CustomerFilterState> {
  CustomerFilterCubit({required this.repository})
    : super(const CustomerFilterState());

  final CustomerFilterRepository repository;

  void updateViewType(FilterViewType viewType) {
    emit(
      state.copyWith(
        viewType: viewType,
      ),
    );
  }

  void setCapacityRange(int min, int max) {
    emit(
      state.copyWith(
        minCapacity: min,
        maxCapacity: max,
      ),
    );
  }

  void setPriceFrom(double? priceFrom) {
    emit(
      state.copyWith(
        priceFrom: priceFrom,
      ),
    );
  }

  void setPriceTo(double? priceTo) {
    emit(
      state.copyWith(
        priceTo: priceTo,
      ),
    );
  }

  void setCity(City? city) {
    emit(
      state.copyWith(
        city: city,
      ),
    );
  }

  void clearFilters() {
    emit(
      state.copyWith(
        minCapacity: 0,
        maxCapacity: 1000000,
        priceFrom: null,
        priceTo: null,
        city: null,
        capacity: null,
      ),
    );
  }
}

