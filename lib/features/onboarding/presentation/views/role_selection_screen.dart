import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/enums/role_type.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/cubit.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/state.dart';
import 'package:plugdin/features/onboarding/presentation/widgets/role_selection_widget.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackArrowIcon(
          onTap: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Column(
          children: [
            Text(
              'What are you using PlugdIn for?',
              style: context.h1,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "Choose how you'd like to use the platform, and we'll prepare the right setup for you.",
              style: context.b2.copyWith(
                color: AppColors.darkGreyTextColor,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
              builder: (context, state) {
                return Row(
                  children: [
                    RoleSelectionWidget(
                      title: RoleType.vendor.toDisplayName,
                      iconPath: state.selectedRoleType == RoleType.vendor
                          ? AssetPaths.selectedHouseIcon
                          : AssetPaths.unselectedHouseIcon,
                      isSelected: state.selectedRoleType == RoleType.vendor,
                      onTap: () {
                        context.read<OnboardingFlowCubit>().selectRole(
                          RoleType.vendor,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    RoleSelectionWidget(
                      title: RoleType.customer.toDisplayName,
                      iconPath: state.selectedRoleType == RoleType.customer
                          ? AssetPaths.selectedCustomerIcon
                          : AssetPaths.unselectedCustomerIcon,
                      isSelected: state.selectedRoleType == RoleType.customer,
                      onTap: () {
                        context.read<OnboardingFlowCubit>().selectRole(
                          RoleType.customer,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
          builder: (context, state) {
            return PIButton(
              text: 'Next',
              onPressed: () {},
              outsidePadding: const EdgeInsetsDirectional.symmetric(
                horizontal: 16,
              ),
            );
          },
        ),
      ),
    );
  }
}
