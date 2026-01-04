import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/features/vendor/home/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/home/presentation/cubit/state.dart';
import 'package:plugdin/features/vendor/store/data/models/package_model.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/utils/widgets/core_widgets/error_widget.dart';
import 'package:plugdin/utils/widgets/core_widgets/images/cached_network_image_widget.dart';
import 'package:plugdin/utils/widgets/core_widgets/loading_widget.dart';

class PackageDetailScreen extends StatefulWidget {
  const PackageDetailScreen({
    required this.packageId,
    this.initialPackage,
    super.key,
  });

  final String packageId;
  final PackageModel? initialPackage;

  @override
  State<PackageDetailScreen> createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<VendorHomeCubit>().fetchPackageById(widget.packageId);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Color _statusColor(String status) {
    final normalized = status.toLowerCase();
    if (normalized == 'active') return AppColors.green;
    if (normalized == 'pending') return AppColors.amber;
    return AppColors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Package Details'),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              context.pushNamed(
                AppRouteNames.packageAvailabilityCalendarScreen,
                pathParameters: {'packageId': widget.packageId},
              );
            },
            child: const Text('Book Now'),
          ),
        ),
      ),
      body: BlocBuilder<VendorHomeCubit, VendorHomeState>(
        buildWhen: (previous, current) =>
            previous.packageDetail != current.packageDetail,
        builder: (context, state) {
          final detailState = state.packageDetail;

          if (detailState.isLoading) {
            return const Center(child: LoadingWidget());
          }
          if (detailState.isFailure) {
            return PIErrorWidget(
              errorText:
                  detailState.errorMessage ?? 'Failed to load package details.',
              onPressed: () {
                context.read<VendorHomeCubit>().fetchPackageById(
                  widget.packageId,
                );
              },
            );
          }

          final package = detailState.data ?? widget.initialPackage;
          if (package == null) {
            return PIErrorWidget(
              errorText: 'Package not found.',
              onPressed: () {},
            );
          }

          final statusColor = _statusColor(package.status);
          final media = package.media;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (media.isNotEmpty)
                  Column(
                    children: [
                      SizedBox(
                        height: 220,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: media.length,
                          onPageChanged: (index) {
                            setState(() => _currentPage = index);
                          },
                          itemBuilder: (context, index) {
                            return PICNIWidget(
                              imageUrl: media[index],
                              borderRadius: BorderRadius.circular(16),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(media.length, (index) {
                          final isActive = _currentPage == index;
                          return Container(
                            width: isActive ? 12 : 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.secondaryColor
                                  : AppColors.greyShade2,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        }),
                      ),
                    ],
                  )
                else
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.greyShade3,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'No images available',
                      style: context.l3.copyWith(color: AppColors.darkGrey),
                    ),
                  ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            package.title,
                            style: context.h1,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            package.description,
                            style: context.l3.copyWith(
                              color: AppColors.darkGrey,
                            ),
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
                const SizedBox(height: 16),
                Row(
                  children: [
                    _InfoTile(
                      icon: Icons.sell_outlined,
                      label: 'Subprice',
                      value: 'PKR ${package.subprice}',
                    ),
                    const SizedBox(width: 8),
                    _InfoTile(
                      icon: Icons.payments_outlined,
                      label: 'Total Price',
                      value: 'PKR ${package.totalPrice}',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _InfoTile(
                      icon: Icons.event_available_outlined,
                      label: 'Bookings',
                      value: '${package.bookingCount}',
                    ),
                    const SizedBox(width: 8),
                    _InfoTile(
                      icon: Icons.person_outline,
                      label: 'Vendors',
                      value: '${package.vendorEmails.length}',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (package.vendorEmails.isNotEmpty) ...[
                  Text(
                    'Assigned Vendors',
                    style: context.h3,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: package.vendorEmails
                        .map(
                          (email) => Chip(
                            label: Text(
                              email,
                              style: context.l3.copyWith(
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            backgroundColor: AppColors.secondaryColor
                                .withValues(alpha: 0.08),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                ],
                if (package.approvedVendors.isNotEmpty) ...[
                  Text(
                    'Approved Vendors',
                    style: context.h3,
                  ),
                  const SizedBox(height: 8),
                  ...package.approvedVendors.map(
                    (vendor) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: AppColors.secondaryColor.withValues(
                          alpha: 0.12,
                        ),
                        child: Text(
                          vendor.companyName.isNotEmpty
                              ? vendor.companyName.characters.first
                              : '-',
                          style: context.l3.copyWith(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      title: Text(
                        vendor.companyName.isNotEmpty
                            ? vendor.companyName
                            : 'Unknown vendor',
                        style: context.b2,
                      ),
                      subtitle: Text(
                        vendor.city,
                        style: context.l3.copyWith(
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                Text(
                  'Created At: ${package.createdAt.isNotEmpty ? package.createdAt : 'N/A'}',
                  style: context.l3.copyWith(
                    color: AppColors.darkGrey,
                  ),
                ),
                Text(
                  'Updated At: ${package.updatedAt.isNotEmpty ? package.updatedAt : 'N/A'}',
                  style: context.l3.copyWith(
                    color: AppColors.darkGrey,
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

class _InfoTile extends StatelessWidget {
  const _InfoTile({
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
                    color: AppColors.darkGrey,
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
