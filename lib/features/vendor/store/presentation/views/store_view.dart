import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/responsive_helper.dart';
import 'package:plugdin/utils/helpers/toast_helper.dart';
import 'package:plugdin/utils/widgets/core_widgets/dialog_widget.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';
import 'package:plugdin/utils/widgets/core_widgets/images/svg_pic.dart';
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

  void _handleDeletePost(String postId, int postIndex) {
    FitThereDialogWidget.show(
      context,
      headingText: 'Delete Post',
      subHeadingText: 'Are you sure you want to delete this post? This action cannot be undone.',
      optionOneText: 'Cancel',
      optionTwoText: 'Delete',
      onOptionOneTextPress: () {
        // User cancelled, do nothing
      },
      onOptionTwoTextPress: () {
        context.read<VendorStoreCubit>().handleDeletePost(postId, postIndex);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VendorStoreCubit, VendorStoreState>(
      listener: (context, state) {
        // Handle delete post state changes
        if (state.deletePostState.isLoaded) {
          ToastHelper.showSuccessToast('Post deleted successfully');
          context.read<VendorStoreCubit>().resetDeletePostState();
        } else if (state.deletePostState.isFailure) {
          ToastHelper.showErrorToast(
            state.deletePostState.errorMessage ?? 'Failed to delete post',
          );
          context.read<VendorStoreCubit>().resetDeletePostState();
        }
      },
      builder: (context, state) {
        if (state.storeMedia.isLoading) {
          return const LoadingWidget();
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
        // if (state.storeMedia.isEmpty) {
        //   return const EmptyWidget(
        //     text: 'No media found.',
        //   );
        // }
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
            final postId = vendor?.id ?? '';
            final isDeleting = state.deletePostState.isLoading;
            
            return Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: 8,
              ),
              child: Stack(
                children: [
                  PICNIWidget(
                    imageUrl: vendor?.media.first.fileUrl ?? '',
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: isDeleting
                          ? null
                          : () => _handleDeletePost(postId, index),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: isDeleting
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.white,
                                  ),
                                ),
                              )
                            : const PISvgPic(
                                AssetPaths.binIcon,
                                width: 16,
                                height: 16,
                                color: AppColors.white,
                              ),
                      ),
                    ),
                  ),
                ],
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
