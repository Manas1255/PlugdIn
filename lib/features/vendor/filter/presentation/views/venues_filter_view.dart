import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_constants.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/core/enums/filter_view_type.dart';
import 'package:plugdin/features/vendor/filter/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/filter/presentation/cubit/state.dart';

class VenuesFilterView extends StatelessWidget {
  const VenuesFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorFilterCubit, VendorFilterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 30,
            end: 30,
            top: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<VendorFilterCubit>().updateViewType(
                        FilterViewType.normalDisplayView,
                      );
                    },
                    child: SvgPicture.asset(
                      AssetPaths.backIcon,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Venues',
                    style: context.h3.copyWith(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                'Capacity',
                style: context.b1.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 12,
              ),

              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  overlayShape: SliderComponentShape.noOverlay,
                  thumbColor: AppColors.secondaryColor,
                  activeTrackColor: AppColors.secondaryColor,
                  inactiveTrackColor: AppColors.lightGreyColor,
                ),
                child: RangeSlider(
                  values: RangeValues(
                    state.minCapacity.toDouble(),
                    state.maxCapacity.toDouble(),
                  ),
                  min: AppConstants.minCapacityRange.toDouble(),
                  max: AppConstants.maxCapacityRange.toDouble(),
                  divisions: AppConstants.priceRangeDivisions,
                  onChanged: (RangeValues values) {
                    context.read<VendorFilterCubit>().setCapacityRange(
                      values.start.toInt(),
                      values.end.toInt(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.minCapacity.toString(),
                    style: context.b2.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    state.maxCapacity.toString(),
                    style: context.b2.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
