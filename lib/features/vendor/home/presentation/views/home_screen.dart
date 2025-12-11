import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_constants.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/core/enums/category_type.dart';
import 'package:plugdin/features/vendor/home/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/home/presentation/cubit/state.dart';
import 'package:plugdin/features/vendor/profile/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/profile/presentation/cubit/state.dart';
import 'package:plugdin/features/vendor/store/data/models/package_model.dart';
import 'package:plugdin/features/vendor/home/presentation/widgets/package_card.dart';
import 'package:plugdin/go_router/exports.dart';
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
    context.read<VendorHomeCubit>().fetchAllPackages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorHomeCubit, VendorHomeState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            await context.read<VendorHomeCubit>().fetchAllVendors();
            await context.read<VendorHomeCubit>().fetchAllPackages();
          },
          child: Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              leadingWidth: 72,
              leading: Padding(
                padding: const EdgeInsetsDirectional.only(start: 12),
                child: PICNIWidget(
                  imageUrl: AppConstants.appPlaceHolderSellerImage,
                  borderRadius: BorderRadius.circular(100),
                ),
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
                GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      AppRouteNames.vendorNotificationsScreen,
                    );
                  },
                  child: Container(
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
                ),
              ],
            ),
            body: _buildBody(context, state),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, VendorHomeState state) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
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
                  if (state.allVendors.isLoading)
                    const SizedBox(
                      height: 300,
                      child: Center(
                        child: LoadingWidget(),
                      ),
                    )
                  else if (state.allVendors.isFailure)
                    PIErrorWidget(
                      errorText:
                          state.allVendors.errorMessage ??
                          'Something went wrong',
                      onPressed: () {
                        context.read<VendorHomeCubit>().fetchAllVendors(
                          filter: state.selectedFilter,
                        );
                      },
                    )
                  else if (state.allVendors.isEmpty)
                    const EmptyWidget(
                      text: 'No Vendors Found',
                    )
                  else ...[
                    Text(
                      'Featured Vendors',
                      style: context.h1,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.6,
                      child: PaginatedBuilder(
                        isGrid: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.75,
                            ),
                        scrollDirection: Axis.horizontal,
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
                                context.pushNamed(
                                  AppRouteNames.vendorOtherVendorStoreScreen,
                                  pathParameters: {
                                    'vendorId': vendor?.id ?? '',
                                  },
                                );
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
                                state.allVendors.data?.pagination?.nextPage ??
                                1,
                          );
                        },
                        isLoading: state.allVendors.isLoading,
                        isLoadingMore: state.allVendors.isPageLoading,
                        hasMoreData:
                            state.allVendors.data?.pagination?.hasNextPage ??
                            false,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text('Featured Packages', style: context.h1),
                    const SizedBox(height: 8),
                    Builder(
                      builder: (context) {
                        final packagesState = state.allPackages;
                        if (packagesState.isLoading) {
                          return const SizedBox(
                            height: 300,
                            child: Center(child: LoadingWidget()),
                          );
                        }
                        if (packagesState.isFailure) {
                          return PIErrorWidget(
                            errorText:
                                packagesState.errorMessage ?? 'Something went wrong',
                            onPressed: () {
                              context.read<VendorHomeCubit>().fetchAllPackages();
                            },
                          );
                        }
                        if (packagesState.isEmpty) {
                          return const EmptyWidget(text: 'No Packages Found');
                        }

                        final packages = packagesState.data?.packages ?? [];
                        return SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.6,
                          child: PaginatedBuilder<PackageModel>(
                            isGrid: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 0.78,
                                ),
                            scrollDirection: Axis.horizontal,
                            items: packages,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, item, index) {
                              final package = packages[index];
                              return Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  bottom: 8,
                                ),
                                child: PackageCard(
                                  package: package,
                                  onTap: () {
                                    context.pushNamed(
                                      AppRouteNames.packageDetailScreen,
                                      pathParameters: {'packageId': package.id},
                                      extra: package,
                                    );
                                  },
                                ),
                              );
                            },
                            onRefresh: () async {
                              await context
                                  .read<VendorHomeCubit>()
                                  .fetchAllPackages();
                            },
                            onLoadMore: () async {
                              await context.read<VendorHomeCubit>().fetchAllPackages(
                                    pageNumber: packagesState
                                            .data?.pagination?.nextPage ??
                                        1,
                                  );
                            },
                            isLoading: packagesState.isLoading,
                            isLoadingMore: packagesState.isPageLoading,
                            hasMoreData:
                                packagesState.data?.pagination?.hasNextPage ??
                                    false,
                          ),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
