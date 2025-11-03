import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/features/profile/presentation/cubit/cubit.dart';
import 'package:plugdin/features/profile/presentation/cubit/state.dart';

class NotificationsToggleWidget extends StatelessWidget {
  const NotificationsToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Notifications',
                  style: context.h3.copyWith(
                    color: AppColors.secondaryColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Transform.scale(
              scale: 0.8,
              child: Switch.adaptive(
                activeColor: AppColors.secondaryColor,
                value: state.notificationsEnabled,
                onChanged: (value) {
                  context.read<ProfileCubit>().toggleNotifications(
                    isEnabled: value,
                  );
                  context.read<ProfileCubit>().updateUserPreferences();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
