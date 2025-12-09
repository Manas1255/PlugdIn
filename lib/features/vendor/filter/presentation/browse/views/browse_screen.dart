import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/core/enums/filter_view_type.dart';
import 'package:plugdin/features/vendor/filter/presentation/browse/cubit/cubit.dart';
import 'package:plugdin/features/vendor/filter/presentation/browse/cubit/state.dart';
import 'package:plugdin/features/vendor/filter/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/filter/presentation/cubit/state.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';
import 'package:plugdin/utils/widgets/vendor_card_widget.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  @override
  void initState() {
    super.initState();
    _fetchFilteredVendors();
  }

  void _fetchFilteredVendors() {
    final filterState = context.read<VendorFilterCubit>().state;
    context.read<BrowseCubit>().fetchFilteredVendors(
      viewType: filterState.viewType,
      city: filterState.city,
      priceFrom: filterState.priceFrom,
      priceTo: filterState.priceTo,
      capacity: filterState.capacity ?? filterState.minCapacity,
      feature: filterState.feature,
      page: 1,
      limit: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Filtered Results',
          style: context.h3.copyWith(
            fontSize: 18,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _fetchFilteredVendors();
        },
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Featured',
                style: context.h1,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: BlocBuilder<BrowseCubit, BrowseState>(
                  builder: (context, state) {
                    if (state.filteredVendors.isLoading) {
                      return const LoadingWidget();
                    }
                    if (state.filteredVendors.isFailure) {
                      return PIErrorWidget(
                        errorText:
                            state.filteredVendors.errorMessage ??
                            'Something went wrong',
                        onPressed: () {
                          _fetchFilteredVendors();
                        },
                      );
                    }
                    if (state.filteredVendors.isEmpty) {
                      return const EmptyWidget(
                        text: 'No Vendors Found',
                      );
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final vendor = state.filteredVendors.data?.vendors[index];
                        return VendorCardWidget(
                          companyName: vendor?.companyName ?? '',
                          primaryCategory: vendor?.primaryCategory ?? '',
                          location: vendor?.address ?? '',
                          onTap: () {
                            context.pushNamed(
                              AppRouteNames.vendorOtherVendorStoreScreen,
                              pathParameters: {'vendorId': vendor?.id ?? ''},
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 8,
                        );
                      },
                      itemCount: state.filteredVendors.data?.vendors.length ?? 0,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
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

