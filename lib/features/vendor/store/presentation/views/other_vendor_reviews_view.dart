import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugdin/features/vendor/store/data/models/add_review_response_model.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
import 'package:plugdin/features/vendor/store/presentation/widgets/reviews_widget.dart';
import 'package:plugdin/utils/widgets/paginated_builder.dart';

class OtherVendorReviewsView extends StatefulWidget {
  const OtherVendorReviewsView({
    required this.vendorId,
    super.key,
  });

  final String vendorId;

  @override
  State<OtherVendorReviewsView> createState() => _OtherVendorReviewsViewState();
}

class _OtherVendorReviewsViewState extends State<OtherVendorReviewsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<VendorStoreCubit, VendorStoreState>(
        builder: (context, state) {
          final reviewsState = state.otherVendorReviews;
          final reviews = reviewsState.data?.reviews ?? [];

          return PaginatedBuilder<ReviewModel>(
            items: reviews,
            padding: const EdgeInsets.all(20),
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, review, index) {
              return ReviewItemWidget(review: review);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            onRefresh: () async {
              await context.read<VendorStoreCubit>().getVendorReviewsById(
                    vendorId: widget.vendorId,
                  );
            },
            onLoadMore: () async {
              final cubit = context.read<VendorStoreCubit>();
              final currentState = cubit.state;
              final pagination = currentState.otherVendorReviews.data?.pagination;

              if (pagination != null && pagination.hasNextPage) {
                final nextPage =
                    pagination.nextPage ?? (pagination.currentPage + 1);
                await cubit.getVendorReviewsById(
                  vendorId: widget.vendorId,
                  pageNumber: nextPage,
                );
              }
            },
            isLoading: reviewsState.isLoading,
            isLoadingMore: reviewsState.isPageLoading,
            hasMoreData: reviewsState.data?.pagination?.hasNextPage ?? false,
            emptyTitle: 'No reviews yet.',
            emptySubtitle: 'Reviews from customers will appear here.',
            errorMessage: reviewsState.isFailure
                ? (reviewsState.errorMessage ?? 'Failed to load reviews.')
                : null,
            onRetry: () {
              context.read<VendorStoreCubit>().getVendorReviewsById(
                    vendorId: widget.vendorId,
                  );
            },
          );
        },
      ),
    );
  }
}
