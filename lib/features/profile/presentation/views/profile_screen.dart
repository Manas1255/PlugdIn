import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_constants.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/features/profile/presentation/widgets/notifications_toggle_widget.dart';
import 'package:plugdin/features/profile/presentation/widgets/settings_tile_widget.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackArrowIcon(
          onTap: () {
            context.pop();
          },
        ),
        title: Text(
          'Profile',
          style: context.h3,
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 38,
          vertical: 24,
        ),
        child: Column(
          children: [
            PICNIWidget(
              imageUrl: AppConstants.appPlaceHolderUrlImage,
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
              'Alex bhatti',
              style: context.h3,
            ),
            Text(
              '@alexbhatti1122',
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
                      AppRouteNames.personalInfoScreen,
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
                      AppRouteNames.changePasswordScreen,
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
                NotificationsToggleWidget(),
                GestureDetector(
                  onTap: () {},
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
                  onTap: () {},
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
      ),
    );
  }
}
