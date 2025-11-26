import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/core/enums/store_view_type.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
import 'package:plugdin/features/vendor/store/presentation/views/details_view.dart';
import 'package:plugdin/features/vendor/store/presentation/views/packages_view.dart';
import 'package:plugdin/features/vendor/store/presentation/views/reviews_view.dart';
import 'package:plugdin/features/vendor/store/presentation/views/store_view.dart';
import 'package:plugdin/features/vendor/store/presentation/widgets/store_details_widget.dart';
import 'package:plugdin/features/vendor/store/presentation/widgets/store_header_widget.dart';
import 'package:plugdin/utils/widgets/core_widgets/error_widget.dart';
import 'package:plugdin/utils/widgets/core_widgets/loading_widget.dart';
import 'package:plugdin/utils/widgets/core_widgets/no_data_widget.dart';
import 'package:plugdin/utils/widgets/pi_tab_bar.dart';

class VendorStoreScreen extends StatefulWidget {
  const VendorStoreScreen({super.key});

  @override
  State<VendorStoreScreen> createState() => _VendorStoreScreenState();
}

class _VendorStoreScreenState extends State<VendorStoreScreen> {
  late PageController _pageController;

  void _onPageChanged(int index) {
    final viewType = index == 0
        ? StoreViewType.storeView
        : index == 1
        ? StoreViewType.detailsView
        : index == 2
        ? StoreViewType.packagesView
        : StoreViewType.reviewsView;
    context.read<VendorStoreCubit>().updateSelectedStoreViewType(
      viewType,
    );
  }

  void _animateToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    context.read<VendorStoreCubit>().getVendorStoreInfo();
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 8,
        shadowColor: AppColors.black.withValues(alpha: 0.25),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
        surfaceTintColor: AppColors.white,
        title: BlocBuilder<VendorStoreCubit, VendorStoreState>(
          builder: (context, state) {
            return Text(
              '@${state.vendorStoreInfo.data?.userId.username ?? 'N/A'}',
              style: context.h3.copyWith(
                fontSize: 18,
              ),
            );
          },
        ),
      ),
      body: BlocBuilder<VendorStoreCubit, VendorStoreState>(
        builder: (context, state) {
          if (state.vendorStoreInfo.isLoading) {
            return const LoadingWidget();
          }
          if (state.vendorStoreInfo.isFailure) {
            return PIErrorWidget(
              onPressed: () {
                context.read<VendorStoreCubit>().getVendorStoreInfo();
              },
              errorText:
                  state.vendorStoreInfo.errorMessage ??
                  'Unexpected error occurred',
            );
          }
          if (state.vendorStoreInfo.isEmpty) {
            return const EmptyWidget(
              text: 'No store information available.',
            );
          }
          return Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) => [
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StoreHeaderWidget(
                                  reviewCount:
                                      state.vendorStoreInfo.data?.reviews ?? 0,
                                  rating:
                                      state.vendorStoreInfo.data?.ratings ?? 0,
                                  listingCount: 12,
                                ),
                                SizedBox(height: 16),
                                StoreDetailsWidget(
                                  companyName:
                                      state.vendorStoreInfo.data?.companyName ??
                                      'N/A',
                                  primaryCategory:
                                      state
                                          .vendorStoreInfo
                                          .data
                                          ?.primaryCategory ??
                                      'N/A',
                                  location:
                                      state.vendorStoreInfo.data?.address ??
                                      'N/A',
                                  businessDescription:
                                      state
                                          .vendorStoreInfo
                                          .data
                                          ?.businessDescription ??
                                      'N/A',
                                ),
                              ],
                            ),
                          ),
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: _SliverTabBarDelegate(
                              child: PreferredSize(
                                preferredSize: const Size.fromHeight(48),
                                child: PITabBar(
                                  tabOneText: 'Store',
                                  tabTwoText: 'Details',
                                  tabThreeText: 'Packages',
                                  tabFourText: 'Reviews',
                                  onTabOnePress: () => _animateToPage(0),
                                  onTabTwoPress: () => _animateToPage(1),
                                  onTabThreePress: () => _animateToPage(2),
                                  onTabFourPress: () => _animateToPage(3),
                                  selectedIndex:
                                      state.storeViewType ==
                                          StoreViewType.storeView
                                      ? 0
                                      : state.storeViewType ==
                                            StoreViewType.detailsView
                                      ? 1
                                      : state.storeViewType ==
                                            StoreViewType.packagesView
                                      ? 2
                                      : 3,
                                ),
                              ),
                            ),
                          ),
                        ],
                    body: PageView(
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        StoreView(),
                        DetailsView(),
                        PackagesView(),
                        ReviewsView(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate({required this.child});

  final PreferredSizeWidget child;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: overlapsContent ? 2 : 0,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _SliverTabBarDelegate old) => old.child != child;
}
