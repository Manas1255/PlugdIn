import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/core/field_validators.dart';
import 'package:plugdin/utils/helpers/focus_handler.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        body: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
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
              PITextField(
                hintText: 'First Name',
                controller: _firstNameController,
                validator: FieldValidators.nameValidator,
              ),
              const SizedBox(
                height: 16,
              ),
              PITextField(
                hintText: 'Last Name',
                controller: _lastNameController,
                validator: FieldValidators.nameValidator,
              ),
              const SizedBox(
                height: 16,
              ),

              PITextField(
                hintText: 'Email',
                controller: _emailController,
                validator: FieldValidators.emailValidator,
              ),
              const SizedBox(
                height: 16,
              ),
              PITextField(
                hintText: 'Address',
                controller: _addressController,
              ),
              const SizedBox(
                height: 16,
              ),
              PITextField(
                hintText: 'City',
                controller: _cityController,
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
        bottomNavigationBar: SafeArea(
          child: PIButton(
            text: 'Next',
            onPressed: () {},
            outsidePadding: const EdgeInsetsDirectional.symmetric(
              horizontal: 16,
            ),
          ),
        ),
      ),
    );
  }
}
