import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_constants.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/core/enums/store_view_type.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
import 'package:plugdin/features/vendor/store/presentation/views/other_vendor_details_view.dart';
import 'package:plugdin/features/vendor/store/presentation/views/other_vendor_packages_view.dart';
import 'package:plugdin/features/vendor/store/presentation/views/other_vendor_reviews_view.dart';
import 'package:plugdin/features/vendor/store/presentation/views/other_vendor_store_view.dart';
import 'package:plugdin/features/vendor/store/presentation/widgets/store_details_widget.dart';
import 'package:plugdin/features/vendor/store/presentation/widgets/store_header_widget.dart';
import 'package:plugdin/utils/widgets/core_widgets/error_widget.dart';
import 'package:plugdin/utils/widgets/core_widgets/loading_widget.dart';
import 'package:plugdin/utils/widgets/core_widgets/no_data_widget.dart';
import 'package:plugdin/utils/widgets/pi_tab_bar.dart';

class OtherVendorStoreScreen extends StatefulWidget {
  const OtherVendorStoreScreen({
    required this.vendorId,
    super.key,
  });

  final String vendorId;

  @override
  State<OtherVendorStoreScreen> createState() => _OtherVendorStoreScreenState();
}

class _OtherVendorStoreScreenState extends State<OtherVendorStoreScreen> {
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
    final cubit = context.read<VendorStoreCubit>();
    cubit.getVendorById(widget.vendorId);
    cubit.getVendorReviewsById(vendorId: widget.vendorId);
    cubit.getVendorPackagesById(vendorId: widget.vendorId);
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
              '@${state.otherVendorStoreInfo.data?.userId.username ?? 'N/A'}',
              style: context.h3.copyWith(
                fontSize: 18,
              ),
            );
          },
        ),
      ),
      body: BlocBuilder<VendorStoreCubit, VendorStoreState>(
        builder: (context, state) {
          if (state.otherVendorStoreInfo.isLoading) {
            return const LoadingWidget();
          }
          if (state.otherVendorStoreInfo.isFailure) {
            return PIErrorWidget(
              onPressed: () {
                context.read<VendorStoreCubit>().getVendorById(widget.vendorId);
              },
              errorText:
                  state.otherVendorStoreInfo.errorMessage ??
                  'Unexpected error occurred',
            );
          }
          if (state.otherVendorStoreInfo.isEmpty) {
            return const EmptyWidget(
              text: 'No store information available.',
            );
          }
          return Column(
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
                              Padding(
                                padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 24,
                                  vertical: 20,
                                ),
                                child: StoreHeaderWidget(
                                  reviewCount:
                                      state
                                          .otherVendorStoreInfo
                                          .data
                                          ?.reviews ??
                                      0,
                                  rating:
                                      state
                                          .otherVendorStoreInfo
                                          .data
                                          ?.ratings ??
                                      0,
                                  listingCount: 12,
                                  companyLogo:
                                      state
                                          .otherVendorStoreInfo
                                          .data
                                          ?.companyLogo ??
                                      AppConstants.appPlaceHolderUrlImage,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 24,
                                ),
                                child: StoreDetailsWidget(
                                  companyName:
                                      state
                                          .otherVendorStoreInfo
                                          .data
                                          ?.companyName ??
                                      'N/A',
                                  primaryCategory:
                                      state
                                          .otherVendorStoreInfo
                                          .data
                                          ?.primaryCategory ??
                                      'N/A',
                                  location:
                                      state
                                          .otherVendorStoreInfo
                                          .data
                                          ?.address ??
                                      'N/A',
                                  businessDescription:
                                      state
                                          .otherVendorStoreInfo
                                          .data
                                          ?.businessDescription ??
                                      'N/A',
                                ),
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
                        const OtherVendorStoreView(),
                        const OtherVendorDetailsView(),
                        OtherVendorPackagesView(vendorId: widget.vendorId),
                        OtherVendorReviewsView(vendorId: widget.vendorId),
                      ],
                    ),
                  ),
                ),
              ],
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
