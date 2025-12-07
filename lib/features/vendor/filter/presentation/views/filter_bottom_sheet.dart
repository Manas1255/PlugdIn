import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugdin/core/enums/filter_view_type.dart';
import 'package:plugdin/features/vendor/filter/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/filter/presentation/cubit/state.dart';
import 'package:plugdin/features/vendor/filter/presentation/views/caterers_filter_view.dart';
import 'package:plugdin/features/vendor/filter/presentation/views/decorators_filter_view.dart';
import 'package:plugdin/features/vendor/filter/presentation/views/event_filters_view.dart';
import 'package:plugdin/features/vendor/filter/presentation/views/musicians_filter_view.dart';
import 'package:plugdin/features/vendor/filter/presentation/views/normal_filter_view.dart';
import 'package:plugdin/features/vendor/filter/presentation/views/photographers_filter_view.dart';
import 'package:plugdin/features/vendor/filter/presentation/views/venues_filter_view.dart';
import 'package:plugdin/features/vendor/filter/presentation/views/videographers_filter_view.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorFilterCubit, VendorFilterState>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    if (state.viewType == FilterViewType.normalDisplayView) ...[
                      const NormalFilterView(),
                    ] else if (state.viewType ==
                        FilterViewType.venuesFilterView) ...[
                      const Expanded(child: VenuesFilterView()),
                    ] else if (state.viewType ==
                        FilterViewType.caterersFilterView) ...[
                      const Expanded(child: CaterersFilterView()),
                    ] else if (state.viewType ==
                        FilterViewType.photographersFilterView) ...[
                      const Expanded(child: PhotographersFilterView()),
                    ] else if (state.viewType ==
                        FilterViewType.eventPlannersFilterView) ...[
                      const Expanded(child: EventFiltersView()),
                    ] else if (state.viewType ==
                        FilterViewType.videographersFilterView) ...[
                      const Expanded(child: VideographersFilterView()),
                    ] else if (state.viewType ==
                        FilterViewType.decoratorsFilterView) ...[
                      const Expanded(child: DecoratorsFilterView()),
                    ] else if (state.viewType ==
                        FilterViewType.musiciansFilterView) ...[
                      const Expanded(child: MusiciansFilterView()),
                    ] else if (state.viewType ==
                        FilterViewType.normalDisplayView) ...[
                      const Expanded(child: NormalFilterView()),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
