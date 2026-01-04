import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/features/vendor/store/data/models/vendor_bookings_response_model.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/date_time_formatter.dart';
import 'package:plugdin/utils/widgets/paginated_builder.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({super.key});

  @override
  State<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> {
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    context.read<VendorStoreCubit>().getVendorBookings();
  }

  Color _getStatusColor(String status) {
    final normalized = status.toLowerCase();
    if (normalized == 'pending') return AppColors.amber;
    if (normalized == 'confirmed') return AppColors.green;
    if (normalized == 'cancelled') return AppColors.red;
    if (normalized == 'completed') return AppColors.blueTextColor;
    return AppColors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() {
                _selectedStatus = value == 'all' ? null : value;
              });
              context.read<VendorStoreCubit>().getVendorBookings(
                    status: _selectedStatus,
                  );
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'all',
                child: Text('All'),
              ),
              const PopupMenuItem(
                value: 'pending',
                child: Text('Pending'),
              ),
              const PopupMenuItem(
                value: 'confirmed',
                child: Text('Confirmed'),
              ),
              const PopupMenuItem(
                value: 'cancelled',
                child: Text('Cancelled'),
              ),
              const PopupMenuItem(
                value: 'completed',
                child: Text('Completed'),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<VendorStoreCubit, VendorStoreState>(
        builder: (context, state) {
          final bookingsState = state.vendorBookings;
          final bookings = bookingsState.data?.bookings ?? [];

          return PaginatedBuilder<BookingModel>(
            items: bookings,
            padding: const EdgeInsets.all(20),
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, booking, index) {
              return _buildBookingCard(booking);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            onRefresh: () async {
              await context.read<VendorStoreCubit>().getVendorBookings(
                    status: _selectedStatus,
                  );
            },
            onLoadMore: () async {
              final cubit = context.read<VendorStoreCubit>();
              final currentState = cubit.state;
              final pagination = currentState.vendorBookings.data?.pagination;

              if (pagination != null && pagination.hasNextPage) {
                final nextPage =
                    pagination.nextPage ?? (pagination.currentPage + 1);
                await cubit.getVendorBookings(
                  pageNumber: nextPage,
                  status: _selectedStatus,
                );
              }
            },
            isLoading: bookingsState.isLoading,
            isLoadingMore: bookingsState.isPageLoading,
            hasMoreData: bookingsState.data?.pagination?.hasNextPage ?? false,
            emptyTitle: 'No bookings yet.',
            emptySubtitle: 'Bookings will appear here once customers book your packages.',
            errorMessage: bookingsState.isFailure
                ? (bookingsState.errorMessage ?? 'Failed to load bookings.')
                : null,
            onRetry: () {
              context.read<VendorStoreCubit>().getVendorBookings(
                    status: _selectedStatus,
                  );
            },
          );
        },
      ),
    );
  }

  Widget _buildBookingCard(BookingModel booking) {
    final statusColor = _getStatusColor(booking.status);
    final startDate = PIDateTimeFormatter.parseAsLocal(booking.startTime);
    final endDate = PIDateTimeFormatter.parseAsLocal(booking.endTime);
    final createdDate = PIDateTimeFormatter.parseAsLocal(booking.createdAt);

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
              // Customer profile picture
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: booking.customerId.profilePicture != null &&
                        booking.customerId.profilePicture!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: booking.customerId.profilePicture!,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 48,
                          height: 48,
                          color: AppColors.lightGreyColor,
                          child: const Icon(
                            Icons.person,
                            color: AppColors.grey,
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 48,
                          height: 48,
                          color: AppColors.lightGreyColor,
                          child: const Icon(
                            Icons.person,
                            color: AppColors.grey,
                          ),
                        ),
                      )
                    : Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.lightGreyColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: AppColors.grey,
                        ),
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.customerId.name.isNotEmpty
                          ? booking.customerId.name
                          : booking.customerId.username.isNotEmpty
                              ? booking.customerId.username
                              : 'Customer',
                      style: context.b2.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    if (booking.customerId.email.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        booking.customerId.email,
                        style: context.l3.copyWith(
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
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
                  booking.status.toUpperCase(),
                  style: context.l3.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Package info
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.greyShade3,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      color: AppColors.secondaryColor,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        booking.packageId.title,
                        style: context.b2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                if (booking.packageId.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    booking.packageId.description,
                    style: context.l3.copyWith(
                      color: AppColors.darkGrey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Date and time info
          Row(
            children: [
              Expanded(
                child: _InfoChip(
                  label: 'Start',
                  value: startDate != null
                      ? '${PIDateTimeFormatter.formatDate(startDate)}\n${PIDateTimeFormatter.formatTime(startDate)}'
                      : 'N/A',
                  icon: Icons.play_circle_outline,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _InfoChip(
                  label: 'End',
                  value: endDate != null
                      ? '${PIDateTimeFormatter.formatDate(endDate)}\n${PIDateTimeFormatter.formatTime(endDate)}'
                      : 'N/A',
                  icon: Icons.stop_circle_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _InfoChip(
                  label: 'Location',
                  value: booking.location.isNotEmpty ? booking.location : 'N/A',
                  icon: Icons.location_on_outlined,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _InfoChip(
                  label: 'Amount',
                  value: 'PKR ${booking.totalAmount}',
                  icon: Icons.payments_outlined,
                ),
              ),
            ],
          ),
          if (booking.notes != null && booking.notes!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.lightGreyColor.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.grey.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.note_outlined,
                    color: AppColors.secondaryColor,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      booking.notes!,
                      style: context.l3.copyWith(
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (createdDate != null) ...[
            const SizedBox(height: 12),
            Text(
              'Booked on ${PIDateTimeFormatter.formatDate(createdDate)}',
              style: context.l3.copyWith(
                color: AppColors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ],
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
    return Container(
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.l3.copyWith(
                    color: AppColors.grey,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: context.b2.copyWith(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
