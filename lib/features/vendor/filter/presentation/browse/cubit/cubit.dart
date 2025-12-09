import 'package:bloc/bloc.dart';
import 'package:plugdin/core/enums/filter_view_type.dart';
import 'package:plugdin/features/vendor/filter/domain/repositories/vendor_filter_repository.dart';
import 'package:plugdin/features/vendor/filter/presentation/browse/cubit/state.dart';
import 'package:plugdin/utils/helpers/data_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit({required this.repository})
    : super(const BrowseState());

  final VendorFilterRepository repository;

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
    String? city,
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

    final response = await repository.getFilteredVendors(
      category: category,
      city: city,
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

