import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/features/vendor/store/data/models/package_model.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';
import 'package:plugdin/utils/widgets/paginated_builder.dart';

class PackagesView extends StatefulWidget {
  const PackagesView({
    this.isOwnStore = true,
    super.key,
  });

  final bool isOwnStore;

  @override
  State<PackagesView> createState() => _PackagesViewState();
}

class _PackagesViewState extends State<PackagesView> {
  @override
  void initState() {
    super.initState();
    if (widget.isOwnStore) {
      context.read<VendorStoreCubit>().getVendorPackages();
    }
  }

  String _formatDate(String? raw) {
    final parsed = DateTime.tryParse(raw ?? '');
    if (parsed == null) return 'N/A';
    return parsed.toLocal().toString().split(' ').first;
  }

  Widget _buildPackageCard(PackageModel package) {
    final statusColor = package.status.toLowerCase() == 'active'
        ? AppColors.green
        : package.status.toLowerCase() == 'pending'
        ? AppColors.amber
        : AppColors.grey;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.grey.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.title,
                      style: context.h3.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      package.description,
                      style: context.l3.copyWith(
                        color: AppColors.darkGrey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  package.status,
                  style: context.l3.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _InfoChip(
                label: 'Subprice',
                value: 'PKR ${package.subprice}',
                icon: Icons.sell_outlined,
              ),
              const SizedBox(width: 8),
              _InfoChip(
                label: 'Total',
                value: 'PKR ${package.totalPrice}',
                icon: Icons.payments_outlined,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _InfoChip(
                label: 'Bookings',
                value: '${package.bookingCount}',
                icon: Icons.event_available_outlined,
              ),
              const SizedBox(width: 8),
              _InfoChip(
                label: 'Created',
                value: _formatDate(package.createdAt),
                icon: Icons.calendar_today_outlined,
              ),
            ],
          ),
          if (package.vendorEmails.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: package.vendorEmails
                  .map(
                    (email) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        email,
                        style: context.l3.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
          const SizedBox(height: 16),
          PIButton(
            text: 'Review Package',
            onPressed: () {
              context.pushNamed(
                AppRouteNames.addReviewScreen,
                extra: package,
              );
            },
            //outsidePadding: EdgeInsets.zero,
            padding: const EdgeInsetsDirectional.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isOwnStore) {
      return Scaffold(
        body: const Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Text(
              'Packages can only be viewed for your own store.',
              style: TextStyle(fontSize: 16, color: AppColors.darkGrey),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: BlocBuilder<VendorStoreCubit, VendorStoreState>(
        builder: (context, state) {
          final packagesState = state.vendorPackages;
          final packages = packagesState.data?.packages ?? [];

          return PaginatedBuilder<PackageModel>(
            items: packages,
            padding: const EdgeInsets.all(20),
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, package, index) {
              return _buildPackageCard(package);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            onRefresh: () async {
              await context.read<VendorStoreCubit>().getVendorPackages();
            },
            onLoadMore: () async {
              final cubit = context.read<VendorStoreCubit>();
              final currentState = cubit.state;
              final pagination = currentState.vendorPackages.data?.pagination;

              if (pagination != null && pagination.hasNextPage) {
                final nextPage =
                    pagination.nextPage ?? (pagination.currentPage + 1);
                await cubit.getVendorPackages(pageNumber: nextPage);
              }
            },
            isLoading: packagesState.isLoading,
            isLoadingMore: packagesState.isPageLoading,
            hasMoreData: packagesState.data?.pagination?.hasNextPage ?? false,
            emptyTitle: 'No packages yet.',
            emptySubtitle: 'Create your first package to get started.',
            errorMessage: packagesState.isFailure
                ? (packagesState.errorMessage ?? 'Failed to load packages.')
                : null,
            onRetry: () {
              context.read<VendorStoreCubit>().getVendorPackages();
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: PIButton(
          text: 'Create Your Package',
          onPressed: () {
            context.pushNamed(
              AppRouteNames.createPackageScreen,
            );
          },
          outsidePadding: const EdgeInsetsDirectional.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.greyShade3,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.secondaryColor,
              size: 18,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.l3.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: context.b2.copyWith(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
