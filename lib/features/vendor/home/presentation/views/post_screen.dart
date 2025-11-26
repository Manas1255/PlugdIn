import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/utils/helpers/toast_helper.dart';
import 'package:plugdin/utils/widgets/image_picker_bottom_sheet.dart';

class VendorPostScreen extends StatefulWidget {
  const VendorPostScreen({super.key});

  @override
  State<VendorPostScreen> createState() => _VendorPostScreenState();
}

class _VendorPostScreenState extends State<VendorPostScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VendorStoreCubit, VendorStoreState>(
      listenWhen: (previous, current) =>
          previous.uploadMediaState != current.uploadMediaState,
      listener: (context, state) {
        if (state.uploadMediaState.isLoaded) {
          ToastHelper.showSuccessToast(
            'Image uploaded successfully!',
          );

          context.read<VendorStoreCubit>().setPostBottomSheetShown(false);
        } else if (state.uploadMediaState.isFailure) {
          ToastHelper.showErrorToast(
            state.uploadMediaState.errorMessage ??
                'Image upload failed. Please try again.',
          );
          // Reset flag after failure so user can try again
          context.read<VendorStoreCubit>().setPostBottomSheetShown(false);
        }
      },
      builder: (context, state) {
        // Show bottom sheet only once per screen visibility
        if (!state.isPostBottomSheetShown) {
          context.read<VendorStoreCubit>().setPostBottomSheetShown(true);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _showImagePickerBottomSheet();
            }
          });
        }

        return const Scaffold(
          body: SizedBox.shrink(),
        );
      },
    );
  }

  Future<void> _showImagePickerBottomSheet() async {
    bool imageSelected = false;

    await ImagePickerBottomSheet.show(
      context,
      onCameraTap: () async {
        imageSelected = true;
        context.pop();
        await context.read<VendorStoreCubit>().pickStoreImageFromCamera();
        await _uploadImage();
      },
      onGalleryTap: () async {
        imageSelected = true;
        context.pop();
        await context.read<VendorStoreCubit>().pickStoreImageFromGallery();
        await _uploadImage();
      },
    );

    if (!imageSelected && mounted) {
      context.go(AppRoutes.vendorStoreScreen);
    }

    if (mounted) {
      context.read<VendorStoreCubit>().setPostBottomSheetShown(false);
    }
  }

  Future<void> _uploadImage() async {
    final state = context.read<VendorStoreCubit>().state;
    if (state.storeImageFile != null) {
      await context.read<VendorStoreCubit>().uploadStoreMedia(
        [state.storeImageFile!.path],
      );
    }
  }
}
