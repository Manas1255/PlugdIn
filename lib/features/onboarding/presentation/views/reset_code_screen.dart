import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/cubit.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/state.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/utils/helpers/focus_handler.dart';
import 'package:plugdin/utils/helpers/toast_helper.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class ResetCodeScreen extends StatefulWidget {
  const ResetCodeScreen({super.key});

  @override
  State<ResetCodeScreen> createState() => _ResetCodeScreenState();
}

class _ResetCodeScreenState extends State<ResetCodeScreen> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }

    // _checkAllFieldsFilled();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) =>
          previous.verifyPasswordResetCode != current.verifyPasswordResetCode,
      listener: (context, state) {
        if (state.verifyPasswordResetCode.isLoaded) {
          ToastHelper.showSuccessToast('Code verified successfully!');
          context.pushNamed(
            AppRouteNames.newPasswordScreen,
          );
        }
        if (state.verifyPasswordResetCode.isFailure) {
          ToastHelper.showErrorToast(
            state.passwordResetCode.errorMessage ?? 'An error occurred',
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
          body: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter the Code',
                  style: context.h1,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Enter the 6-digit code we sent to:',
                  style: context.b2.copyWith(
                    color: AppColors.lightGreyShade2,
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 8,
                      ),
                      child: SizedBox(
                        width: 48,
                        height: 56,
                        child: PITextField(
                          controller: controllers[index],
                          focusNode: focusNodes[index],
                          type: PITextFieldType.number,
                          borderRadius: 6,
                          regularMaxCharacter: 1,
                          textAlign: TextAlign.center,
                          onChanged: (value) => _onChanged(value, index),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              return SafeArea(
                child: PIButton(
                  text: 'Next',
                  onPressed: () {
                    context.read<OnboardingCubit>().verifyPasswordResetCode(
                      code: controllers.map((e) => e.text).join(),
                      email: state.passwordResetEmail,
                    );
                  },
                  outsidePadding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  isLoading: state.verifyPasswordResetCode.isLoading,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
