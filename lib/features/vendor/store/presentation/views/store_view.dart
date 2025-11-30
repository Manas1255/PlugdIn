import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/responsive_helper.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';
import 'package:plugdin/utils/widgets/paginated_builder.dart';

class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  @override
  void initState() {
    context.read<VendorStoreCubit>().getStoreMedia();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VendorStoreCubit, VendorStoreState>(
      builder: (context, state) {
        if (state.storeMedia.isLoading) {
          const LoadingWidget();
        }
        if (state.storeMedia.isFailure) {
          return PIErrorWidget(
            onPressed: () {
              context.read<VendorStoreCubit>().getStoreMedia();
            },
            errorText:
                state.storeMedia.errorMessage ?? 'Unexpected error occurred',
          );
        }
        if (state.storeMedia.isEmpty) {
          return const EmptyWidget(
            text: 'No media found.',
          );
        }
        return PaginatedBuilder(
          isGrid: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ResponsiveHelper.responsive<int>(
              context,
              mobile: 3,
              tablet: 6,
              smallMobile: 2,
            ),
            crossAxisSpacing: ResponsiveHelper.spacing(
              context,
              mobile: 1,
              tablet: 2,
              smallMobile: 1,
            ),
            mainAxisSpacing: ResponsiveHelper.spacing(
              context,
              mobile: 1,
              tablet: 2,
              smallMobile: 1,
            ),
          ),
          items: state.storeMedia.data?.posts ?? [],
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, item, index) {
            final vendor = state.storeMedia.data?.posts[index];
            return Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: 8,
              ),
              child: PICNIWidget(
                imageUrl: vendor?.media.first.fileUrl ?? '',
              ),
            );
          },
          onRefresh: () async {
            await context.read<VendorStoreCubit>().getStoreMedia();
          },
          onLoadMore: () async {
            await context.read<VendorStoreCubit>().getStoreMedia(
              pageNumber: state.storeMedia.data?.pagination.nextPage ?? 1,
            );
          },
          isLoading: state.storeMedia.isLoading,
          isLoadingMore: state.storeMedia.isPageLoading,
          hasMoreData: state.storeMedia.data?.pagination.hasNextPage ?? false,
        );
      },
    );
  }
}
