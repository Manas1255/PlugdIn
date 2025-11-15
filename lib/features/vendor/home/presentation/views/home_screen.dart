import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_constants.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/core/enums/category_type.dart';
import 'package:plugdin/features/vendor/home/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/home/presentation/cubit/state.dart';
import 'package:plugdin/features/vendor/profile/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/profile/presentation/cubit/state.dart';
import 'package:plugdin/utils/widgets/core_widgets/error_widget.dart';
import 'package:plugdin/utils/widgets/core_widgets/images/cached_network_image_widget.dart';
import 'package:plugdin/utils/widgets/core_widgets/loading_widget.dart';
import 'package:plugdin/utils/widgets/core_widgets/no_data_widget.dart';
import 'package:plugdin/utils/widgets/filter_chip_widget.dart';
import 'package:plugdin/utils/widgets/paginated_builder.dart';
import 'package:plugdin/utils/widgets/vendor_card_widget.dart';

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({super.key});

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  @override
  void initState() {
    context.read<VendorProfileCubit>().fetchProfileInfo();
    context.read<VendorHomeCubit>().fetchAllVendors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<VendorHomeCubit>().fetchAllVendors();
      },
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: PICNIWidget(
            imageUrl: AppConstants.appPlaceHolderSellerImage,
            borderRadius: BorderRadius.circular(100),
          ),
          title: BlocBuilder<VendorProfileCubit, VendorProfileState>(
            builder: (context, state) {
              return Text(
                state.profileInfo.data?.personName ?? '',
                style: context.h3,
              );
            },
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(
                right: 16,
              ),
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.secondaryColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                AssetPaths.bellIcon,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 34,
                child: BlocBuilder<VendorHomeCubit, VendorHomeState>(
                  buildWhen: (previous, current) =>
                      previous.selectedFilter != current.selectedFilter,
                  builder: (context, state) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final category = CategoryType.values[index];
                        return PIFilterChipWidget(
                          label: category.toDisplayName(),
                          isSelected: state.selectedFilter == category,
                          onTap: () {
                            context
                                .read<VendorHomeCubit>()
                                .updateSelectedFilter(
                                  filter: category,
                                );
                            context.read<VendorHomeCubit>().fetchAllVendors(
                              filter: category,
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 6,
                        );
                      },
                      itemCount: CategoryType.values.length,
                      scrollDirection: Axis.horizontal,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Featured',
                style: context.h1,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: BlocBuilder<VendorHomeCubit, VendorHomeState>(
                  builder: (context, state) {
                    if (state.allVendors.isLoading) {
                      return const LoadingWidget();
                    }
                    if (state.allVendors.isFailure) {
                      return PIErrorWidget(
                        errorText:
                            state.allVendors.errorMessage ??
                            'Something went wrong',
                        onPressed: () {
                          context.read<VendorHomeCubit>().fetchAllVendors(
                            filter: state.selectedFilter,
                          );
                        },
                      );
                    }
                    if (state.allVendors.isEmpty) {
                      return const EmptyWidget(
                        text: 'No Vendors Found',
                      );
                    }

                    return PaginatedBuilder(
                      items: state.allVendors.data?.vendors ?? [],
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, item, index) {
                        final vendor = state.allVendors.data?.vendors[index];
                        return Padding(
                          padding: const EdgeInsetsDirectional.only(
                            bottom: 8,
                          ),
                          child: VendorCardWidget(
                            companyName: vendor?.companyName ?? '',
                            primaryCategory: vendor?.primaryCategory ?? '',
                            location: vendor?.address ?? '',
                            onTap: () {
                              // Navigate to vendor details
                            },
                          ),
                        );
                      },
                      onRefresh: () async {
                        await context.read<VendorHomeCubit>().fetchAllVendors(
                          filter: state.selectedFilter,
                        );
                      },
                      onLoadMore: () async {
                        await context.read<VendorHomeCubit>().fetchAllVendors(
                          filter: state.selectedFilter,
                          pageNumber:
                              state.allVendors.data?.pagination?.nextPage ?? 1,
                        );
                      },
                      isLoading: state.allVendors.isLoading,
                      isLoadingMore: state.allVendors.isPageLoading,
                      hasMoreData:
                          state.allVendors.data?.pagination?.hasNextPage ??
                          false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
