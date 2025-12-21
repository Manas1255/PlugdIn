import 'package:bloc/bloc.dart';
import 'package:plugdin/core/enums/city.dart';
import 'package:plugdin/core/enums/filter_view_type.dart';
import 'package:plugdin/features/vendor/filter/domain/repositories/vendor_filter_repository.dart';
import 'package:plugdin/features/vendor/filter/presentation/cubit/state.dart';

class VendorFilterCubit extends Cubit<VendorFilterState> {
  VendorFilterCubit({required this.repository})
    : super(const VendorFilterState());

  final VendorFilterRepository repository;

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
