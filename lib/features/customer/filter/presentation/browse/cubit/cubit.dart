import 'package:bloc/bloc.dart';
import 'package:plugdin/core/enums/city.dart';
import 'package:plugdin/core/enums/filter_view_type.dart';
import 'package:plugdin/features/customer/filter/domain/repositories/customer_filter_repository.dart';
import 'package:plugdin/features/customer/filter/presentation/browse/cubit/state.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class CustomerBrowseCubit extends Cubit<CustomerBrowseState> {
  CustomerBrowseCubit({required this.repository})
    : super(const CustomerBrowseState());

  final CustomerFilterRepository repository;

  String? _getCategoryFromViewType(FilterViewType viewType) {
    switch (viewType) {
      case FilterViewType.venuesFilterView:
        return 'venue';
      case FilterViewType.caterersFilterView:
        return 'caterer';
      case FilterViewType.photographersFilterView:
        return 'photographer';
      case FilterViewType.eventPlannersFilterView:
        return 'eventPlanner';
      case FilterViewType.videographersFilterView:
        return 'videographer';
      case FilterViewType.decoratorsFilterView:
        return 'decorator';
      case FilterViewType.musiciansFilterView:
        return 'musician';
      case FilterViewType.normalDisplayView:
        return null;
    }
  }

  Future<void> fetchFilteredVendors({
    required FilterViewType viewType,
    City? city,
    double? priceFrom,
    double? priceTo,
    int? capacity,
    String? feature,
    int page = 1,
    int limit = 10,
  }) async {
    emit(
      state.copyWith(
        filteredVendors: const DataState.loading(),
      ),
    );

    final category = _getCategoryFromViewType(viewType);
    // Convert City enum to string for API call
    final cityString = city?.toName();

    final response = await repository.getFilteredVendors(
      category: category,
      city: cityString,
      priceFrom: priceFrom,
      priceTo: priceTo,
      capacity: capacity,
      feature: feature,
      page: page,
      limit: limit,
    );

    if (response.isSuccess && response.data != null) {
      emit(
        state.copyWith(
          filteredVendors: DataState.loaded(
            data: response.data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          filteredVendors: DataState.failure(
            error: response.message,
          ),
        ),
      );
    }
  }
}

