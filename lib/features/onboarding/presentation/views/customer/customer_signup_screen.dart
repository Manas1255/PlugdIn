import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/core/field_validators.dart';
import 'package:plugdin/enums/role_type.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/cubit.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/focus_handler.dart';
import 'package:plugdin/utils/helpers/toast_helper.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class CustomerSignupScreen extends StatelessWidget {
  CustomerSignupScreen({super.key});

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) =>
          previous.customerEmailSignUp != current.customerEmailSignUp,
      listener: (context, state) {
        if (state.customerEmailSignUp.isLoaded) {
          ToastHelper.showSuccessToast(
            'Sign up successful!',
          );
        } else if (state.customerEmailSignUp.isFailure) {
          ToastHelper.showErrorToast(
            state.customerEmailSignUp.errorMessage ??
                'Sign up failed. Please try again.',
          );
        }
      },
      child: FocusHandler(
        child: Scaffold(
          appBar: AppBar(
            leading: BackArrowIcon(
              onTap: () {
                context.pop();
              },
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter Your Details',
                    style: context.h1,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'This is what will be shown on your profile. Make sure to use your authentic details to help us create a trustworthy community.',
                    style: context.b2.copyWith(
                      color: AppColors.darkGreyTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),

                  Center(
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: AppColors.lightGreyColor,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            AssetPaths.unselectedCustomerIcon,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.black,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                AssetPaths.uploadImageIcon,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 32,
                  ),

                  PITextField(
                    hintText: 'Full Name',
                    controller: _fullNameController,
                    validator: FieldValidators.nameValidator,
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  PITextField(
                    hintText: 'User Name',
                    controller: _userNameController,
                    validator: FieldValidators.usernameValidator,
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  PITextField(
                    hintText: 'Email',
                    controller: _emailController,
                    validator: FieldValidators.emailValidator,
                    type: PITextFieldType.email,
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  PITextField(
                    hintText: 'Password',
                    controller: _passwordController,
                    validator: FieldValidators.passwordValidator,
                    type: PITextFieldType.password,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PITextField(
                    hintText: 'Confirm Password',
                    controller: _confirmPasswordController,
                    validator: FieldValidators.passwordValidator,
                    type: PITextFieldType.password,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              return SafeArea(
                child: PIButton(
                  text: 'Sign Up',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<OnboardingCubit>().customerEmailSignUp(
                        fullName: _fullNameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _passwordController.text,
                        role: state.selectedRoleType ?? RoleType.customer,
                        userName: _userNameController.text.trim(),
                      );
                    }
                  },
                  isLoading: state.customerEmailSignUp.isLoading,
                  outsidePadding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 16,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
