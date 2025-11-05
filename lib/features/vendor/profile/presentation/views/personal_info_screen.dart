import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/core/field_validators.dart';
import 'package:plugdin/features/customer/profile/presentation/cubit/cubit.dart';
import 'package:plugdin/features/customer/profile/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/toast_helper.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class VendorPersonalInfoScreen extends StatefulWidget {
  const VendorPersonalInfoScreen({super.key});

  @override
  State<VendorPersonalInfoScreen> createState() =>
      _VendorPersonalInfoScreenState();
}

class _VendorPersonalInfoScreenState extends State<VendorPersonalInfoScreen> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _userNameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();

    final profileData = context
        .read<CustomerProfileCubit>()
        .state
        .profileInfo
        .data;
    _fullNameController.text = profileData?.name ?? '';
    _userNameController.text = profileData?.username ?? '';
    _emailController.text = profileData?.email ?? '';
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

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
          'Personal Information',
          style: context.h3,
        ),
      ),
      body: BlocBuilder<CustomerProfileCubit, CustomerProfileState>(
        builder: (context, state) {
          // if (state.profileInfo.isLoading) {
          //   return const LoadingWidget();
          // }
          // if (state.profileInfo.isFailure) {
          //   return PIErrorWidget(
          //     errorText:
          //         state.profileInfo.errorMessage ?? 'Unexpected error occurred',
          //     onPressed: () {
          //       context.read<ProfileCubit>().fetchProfileInfo();
          //     },
          //   );
          // }
          // if (state.profileInfo.isEmpty) {
          //   return const EmptyWidget(
          //     text: 'No profile data found',
          //   );
          // }
          return Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Full Name',
                  style: context.b2,
                ),
                const SizedBox(
                  height: 8,
                ),
                PITextField(
                  hintText: 'Full Name',
                  controller: _fullNameController,
                  validator: FieldValidators.nameValidator,
                ),
                const SizedBox(
                  height: 16,
                ),

                Text(
                  'Username',
                  style: context.b2,
                ),
                const SizedBox(
                  height: 8,
                ),
                PITextField(
                  hintText: 'User Name',
                  controller: _userNameController,
                  validator: FieldValidators.usernameValidator,
                ),
                const SizedBox(
                  height: 16,
                ),

                Text(
                  'Email',
                  style: context.b2,
                ),
                const SizedBox(
                  height: 8,
                ),

                PITextField(
                  hintText: 'Email',
                  controller: _emailController,
                  readOnly: true,
                  backgroundColor: AppColors.lightGreyColor,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: BlocConsumer<CustomerProfileCubit, CustomerProfileState>(
          listenWhen: (previous, current) =>
              previous.profileInfo != current.profileInfo,
          listener: (context, state) {
            if (state.profileInfo.isLoaded) {
              ToastHelper.showSuccessToast(
                'Profile info updated successfully',
              );
              context.pop();
            } else if (state.profileInfo.isFailure) {
              ToastHelper.showErrorToast(
                '${state.profileInfo.errorMessage}',
              );
            }
          },
          builder: (context, state) {
            return PIButton(
              text: 'Update',
              onPressed: () {
                context.read<CustomerProfileCubit>().updateProfileInfo(
                  name: _fullNameController.text.trim(),
                  username: _userNameController.text.trim(),
                );
              },
              isLoading: state.profileInfo.isLoading,
              outsidePadding: const EdgeInsetsDirectional.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
            );
          },
        ),
      ),
    );
  }
}
