import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/core/field_validators.dart';
import 'package:plugdin/utils/helpers/focus_handler.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController =
        TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return FocusHandler(
      child: Scaffold(
        appBar: AppBar(
          leading: BackArrowIcon(
            onTap: () {
              context.pop();
            },
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create New Password',
                  style: context.h1,
                ),
                const SizedBox(
                  height: 8,
                ),

                Text(
                  'Please, Enter a new password below that different from the previous password',
                  style: context.b2.copyWith(
                    color: AppColors.lightGreyShade2,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                PITextField(
                  hintText: 'New Password',
                  controller: _passwordController,
                  type: PITextFieldType.password,
                  validator: FieldValidators.passwordValidator,
                ),
                const SizedBox(
                  height: 16,
                ),
                PITextField(
                  hintText: 'Confirm New Password',
                  controller: _confirmPasswordController,
                  type: PITextFieldType.password,
                  validator: (value) =>
                      FieldValidators.confirmPasswordValidator(
                        value,
                        _passwordController,
                      ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: PIButton(
            text: 'Create Password',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.pop();
              }
            },
            outsidePadding: const EdgeInsetsDirectional.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ),
    );
  }
}
