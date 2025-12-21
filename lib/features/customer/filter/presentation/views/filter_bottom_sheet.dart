import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/core/enums/filter_view_type.dart';
import 'package:plugdin/features/customer/filter/presentation/cubit/cubit.dart';
import 'package:plugdin/features/customer/filter/presentation/cubit/state.dart';
import 'package:plugdin/features/customer/filter/presentation/views/caterers_filter_view.dart';
import 'package:plugdin/features/customer/filter/presentation/views/decorators_filter_view.dart';
import 'package:plugdin/features/customer/filter/presentation/views/event_filters_view.dart';
import 'package:plugdin/features/customer/filter/presentation/views/musicians_filter_view.dart';
import 'package:plugdin/features/customer/filter/presentation/views/normal_filter_view.dart';
import 'package:plugdin/features/customer/filter/presentation/views/photographers_filter_view.dart';
import 'package:plugdin/features/customer/filter/presentation/views/venues_filter_view.dart';
import 'package:plugdin/features/customer/filter/presentation/views/videographers_filter_view.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerFilterCubit, CustomerFilterState>(
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
                    ],
                  ],
                ),
              ),
              if (state.viewType != FilterViewType.normalDisplayView) ...[
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 30,
                    end: 30,
                    top: 20,
                    bottom: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: PIButton(
                          text: 'Clear Filters',
                          onPressed: () {
                            context.read<CustomerFilterCubit>().clearFilters();
                          },
                          backgroundColor: Colors.transparent,
                          textColor: AppColors.secondaryColor,
                          isExpanded: false,
                          padding: const EdgeInsetsDirectional.symmetric(
                            vertical: 12,
                          ),

                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: PIButton(
                          text: 'Apply',
                          onPressed: () {
                            context
                              ..pop()
                              ..pushNamed(AppRouteNames.customerBrowseScreen);
                          },
                          suffixIcon: SvgPicture.asset(
                            AssetPaths.filterIcon,
                            colorFilter: const ColorFilter.mode(
                              AppColors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          isExpanded: false,
                          padding: const EdgeInsetsDirectional.symmetric(
                            vertical: 12,
                          ),
                          borderRadius: 8,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

