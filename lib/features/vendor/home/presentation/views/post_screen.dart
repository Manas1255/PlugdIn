import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/toast_helper.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';
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

          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }
        } else if (state.uploadMediaState.isFailure) {
          ToastHelper.showErrorToast(
            state.uploadMediaState.errorMessage ??
                'Image upload failed. Please try again.',
          );

          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsetsDirectional.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const PISvgPic(
                    AssetPaths.postIcon,
                    height: 120,
                    width: 120,
                    color: AppColors.secondaryColor,
                  ),
                  const SizedBox(height: 32),

                  Text(
                    'Create a Post',
                    style: context.t1.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  Text(
                    'Upload an image to share with your customers',
                    style: context.b2.copyWith(
                      color: AppColors.lightGreyShade2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

                  PIButton(
                    text: 'Upload Image',
                    onPressed: state.uploadMediaState.isLoading
                        ? null
                        : _showImagePickerBottomSheet,
                    isLoading: state.uploadMediaState.isLoading,
                    prefixIcon: const PISvgPic(
                      AssetPaths.uploadImageIcon,
                      height: 20,
                      width: 20,
                      color: AppColors.white,
                    ),
                    iconSpacing: 8,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showImagePickerBottomSheet() async {
    await ImagePickerBottomSheet.show(
      context,
      onCameraTap: () async {
        Navigator.of(context, rootNavigator: true).pop();
        await context.read<VendorStoreCubit>().pickStoreImageFromCamera();
        await _uploadImage();
      },
      onGalleryTap: () async {
        Navigator.of(context, rootNavigator: true).pop();
        await context.read<VendorStoreCubit>().pickStoreImageFromGallery();
        await _uploadImage();
      },
    );
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
