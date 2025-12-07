import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/core/enums/filter_view_type.dart';
import 'package:plugdin/features/vendor/filter/presentation/cubit/cubit.dart';

class NormalFilterView extends StatelessWidget {
  const NormalFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.only(
          start: 30,
          end: 30,
          top: 20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filters',
                  style: context.h3.copyWith(
                    fontSize: 24,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: SvgPicture.asset(
                    AssetPaths.crossIcon,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: FilterViewType.values.length,
              itemBuilder: (context, index) {
                final filterType = FilterViewType.values[index];
                return GestureDetector(
                  onTap: () {
                    context.read<VendorFilterCubit>().updateViewType(
                      filterType,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      filterType.toDisplayName(),
                      style: context.t2.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
