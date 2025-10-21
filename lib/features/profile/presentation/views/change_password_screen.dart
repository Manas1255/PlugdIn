import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/core/field_validators.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';
import 'package:plugdin/utils/widgets/core_widgets/text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
          'Change Password',
          style: context.h3,
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Column(
          children: [
            PITextField(
              hintText: 'Current Password',
              controller: _currentPasswordController,
              validator: FieldValidators.passwordValidator,
              type: PITextFieldType.password,
            ),
            const SizedBox(
              height: 16,
            ),
            PITextField(
              hintText: 'New Password',
              controller: _newPasswordController,
              validator: FieldValidators.passwordValidator,
              type: PITextFieldType.password,
            ),
            const SizedBox(
              height: 16,
            ),
            PITextField(
              hintText: 'Confirm Password',
              controller: _confirmPasswordController,
              validator: (value) {
                FieldValidators.confirmPasswordValidator(
                  value,
                  _newPasswordController,
                );
              },
              type: PITextFieldType.password,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: PIButton(
          text: 'Change Password',
          onPressed: () {},
          outsidePadding: const EdgeInsetsDirectional.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
        ),
      ),
    );
  }
}
