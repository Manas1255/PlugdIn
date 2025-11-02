import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/core/field_validators.dart';
import 'package:plugdin/features/profile/presentation/cubit/cubit.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _userNameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();

    final profileData = context.read<ProfileCubit>().state.profileInfo.data;
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
      body: Padding(
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
      ),
      bottomNavigationBar: SafeArea(
        child: PIButton(
          text: 'Update',
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
