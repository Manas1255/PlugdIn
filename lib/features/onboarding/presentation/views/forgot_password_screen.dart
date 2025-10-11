import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/core/field_validators.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/cubit.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/state.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/utils/helpers/toast_helper.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) =>
          previous.passwordResetCode != current.passwordResetCode,
      listener: (context, state) {
        if (state.passwordResetCode.isLoaded) {
          ToastHelper.showSuccessToast(
            'Password reset code sent successfully!',
          );
          context.pushNamed(AppRouteNames.resetCodeScreen);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackArrowIcon(
            onTap: () {
              context.pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Your Password?',
                style: context.h1,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Enter your email to reset your password.',
                style: context.b2.copyWith(
                  color: AppColors.lightGreyShade2,
                ),
              ),
              const SizedBox(
                height: 24,
              ),

              Form(
                key: _formKey,
                child: PITextField(
                  hintText: 'Email',
                  controller: _emailController,
                  type: PITextFieldType.email,
                  validator: FieldValidators.emailValidator,
                ),
              ),
              const SizedBox(
                height: 16,
              ),

              BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, state) {
                  return PIButton(
                    text: 'Send Code',
                    isLoading: state.passwordResetCode.isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<OnboardingCubit>().sendPasswordResetCode(
                          email: _emailController.text.trim(),
                        );
                        context.read<OnboardingCubit>().setPasswordResetEmail(
                          email: _emailController.text.trim(),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
