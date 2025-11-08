import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/core/field_validators.dart';
import 'package:plugdin/features/vendor/profile/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/profile/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/focus_handler.dart';
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
  late final TextEditingController _emailController;
  late final TextEditingController _personNameController;
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _companyNameController;
  late final TextEditingController _userNameController;
  late final TextEditingController _businessDescriptionController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _personNameController = TextEditingController();
    _addressController = TextEditingController();
    _cityController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _companyNameController = TextEditingController();
    _userNameController = TextEditingController();
    _businessDescriptionController = TextEditingController();

    final profileData = context
        .read<VendorProfileCubit>()
        .state
        .profileInfo
        .data;
    _emailController.text = profileData?.email ?? '';
    _personNameController.text = profileData?.personName ?? '';
    _addressController.text = profileData?.address ?? '';
    _cityController.text = profileData?.city ?? '';
    _phoneNumberController.text = profileData?.phoneNumber ?? '';
    _companyNameController.text = profileData?.companyName ?? '';
    _userNameController.text = profileData?.username ?? '';
    _businessDescriptionController.text =
        profileData?.businessDescription ?? '';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _personNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _phoneNumberController.dispose();
    _companyNameController.dispose();
    _userNameController.dispose();
    _businessDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusHandler(
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
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
        body: BlocBuilder<VendorProfileCubit, VendorProfileState>(
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
            return SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(
                    height: 16,
                  ),

                  Text(
                    'Person Name',
                    style: context.b2,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  PITextField(
                    hintText: 'Person Name',
                    controller: _personNameController,
                    validator: FieldValidators.nameValidator,
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  Text(
                    'Address',
                    style: context.b2,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  PITextField(
                    hintText: 'Address',
                    controller: _addressController,
                    validator: FieldValidators.locationValidator,
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  Text(
                    'City',
                    style: context.b2,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  PITextField(
                    hintText: 'City',
                    controller: _cityController,
                    validator: FieldValidators.locationValidator,
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  Text(
                    'Phone Number',
                    style: context.b2,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  PITextField(
                    hintText: 'Phone Number',
                    controller: _phoneNumberController,
                    validator: FieldValidators.phoneValidator,
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  Text(
                    'Company Name',
                    style: context.b2,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  PITextField(
                    hintText: 'Company Name',
                    controller: _companyNameController,
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
                    'Business Description',
                    style: context.b2,
                  ),

                  const SizedBox(
                    height: 8,
                  ),
                  PITextField(
                    hintText: 'Business Description',
                    controller: _businessDescriptionController,
                    validator: FieldValidators.descriptionValidator,
                    type: PITextFieldType.description,
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: SafeArea(
          child: BlocConsumer<VendorProfileCubit, VendorProfileState>(
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
                  context.read<VendorProfileCubit>().updateProfileInfo(
                    personName: _personNameController.text.trim(),
                    address: _addressController.text.trim(),
                    city: _cityController.text.trim(),
                    phoneNumber: _phoneNumberController.text.trim(),
                    companyName: _companyNameController.text.trim(),
                    businessDescription: _businessDescriptionController.text
                        .trim(),
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
      ),
    );
  }
}
