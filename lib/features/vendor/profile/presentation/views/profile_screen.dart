import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_constants.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/features/customer/profile/presentation/cubit/cubit.dart';
import 'package:plugdin/features/customer/profile/presentation/widgets/notifications_toggle_widget.dart';
import 'package:plugdin/features/customer/profile/presentation/widgets/settings_tile_widget.dart';
import 'package:plugdin/features/vendor/profile/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/profile/presentation/cubit/state.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class VendorProfileScreen extends StatelessWidget {
  const VendorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: context.h3,
        ),
      ),
      body: BlocBuilder<VendorProfileCubit, VendorProfileState>(
        builder: (context, state) {
          if (state.profileInfo.isLoading) {
            return const LoadingWidget();
          }
          if (state.profileInfo.isFailure) {
            return PIErrorWidget(
              errorText:
                  state.profileInfo.errorMessage ?? 'Unexpected error occurred',
              onPressed: () {
                context.read<CustomerProfileCubit>().fetchProfileInfo();
              },
            );
          }

          if (state.profileInfo.isEmpty) {
            return const EmptyWidget(
              text: 'No profile data found',
            );
          }
          return Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 38,
              vertical: 24,
            ),
            child: Column(
              children: [
                PICNIWidget(
                  imageUrl:
                      state.profileInfo.data?.companyLogo ??
                      AppConstants.appPlaceHolderUrlImage,
                  height: 158,
                  width: 158,
                  borderRadius: BorderRadius.circular(
                    100,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  state.profileInfo.data?.personName ?? '',
                  style: context.h3,
                ),
                Text(
                  '@${state.profileInfo.data?.username ?? ''}',
                  style: context.b2.copyWith(
                    color: AppColors.grey,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingsTileWidget(
                      icon: AssetPaths.personalInfoIcon,
                      title: 'Personal Information',
                      onTap: () {
                        context.pushNamed(
                          AppRouteNames.vendorPersonalInfoScreen,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SettingsTileWidget(
                      icon: AssetPaths.keyIcon,
                      title: 'Change Password',
                      onTap: () {
                        context.pushNamed(
                          AppRouteNames.customerChangePasswordScreen,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SettingsTileWidget(
                      icon: AssetPaths.termsOfUseIcon,
                      title: 'Open Terms of Use',
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SettingsTileWidget(
                      icon: AssetPaths.lockIcon,
                      title: 'Open Privacy Policy',
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const NotificationsToggleWidget(),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<CustomerProfileCubit>()
                            .showDeleteAccountBottomSheet(
                              context,
                            );
                      },
                      child: Text(
                        'Delete Account',
                        style: context.b2.copyWith(
                          color: AppColors.red,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<CustomerProfileCubit>()
                            .showLogoutBottomSheet(
                              context,
                            );
                      },
                      child: Text(
                        'Log Out',
                        style: context.b2.copyWith(
                          color: AppColors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
