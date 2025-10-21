import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/core/field_validators.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({super.key});
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Column(
          children: [
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
              readOnly: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: PIButton(
          text: 'Confirm',
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
