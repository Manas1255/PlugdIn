import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/cubit.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/focus_handler.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FocusHandler(
      child: Scaffold(
        appBar: AppBar(
          leading: BackArrowIcon(
            onTap: () {
              context.pop();
            },
          ),
        ),
        body: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: context.h1,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    PITextField(
                      hintText: 'Email',
                      controller: _emailController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PITextField(
                      hintText: 'Password',
                      controller: _passwordController,
                      type: PITextFieldType.password,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Forgot Password?',
                          style: context.b2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PIButton(
                      text: 'Login',
                      onPressed: () {
                        context.read<OnboardingCubit>().emailLogin(
                          email: _emailController.text.trim(),
                          password: _passwordController.text,
                        );
                      },
                      isLoading: state.emailLogin.isLoading,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Center(
                      child: Text(
                        'OR',
                        style: context.b1.copyWith(
                          color: AppColors.greyShade2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    PIButton.secondary(
                      text: 'Continue with Google',
                      prefixIcon: SvgPicture.asset(
                        AssetPaths.googleIcon,
                      ),
                      onPressed: () {},
                    ),
                    PIButton.secondary(
                      text: 'Continue with Apple',
                      prefixIcon: SvgPicture.asset(
                        AssetPaths.appleIcon,
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      'By choosing to continue, you agree to PlugdIn’s Terms and Privacy Policy.',
                      textAlign: TextAlign.center,
                      style: context.b3,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
