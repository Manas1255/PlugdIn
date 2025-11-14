import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/core/enums/category_type.dart';
import 'package:plugdin/core/enums/city.dart';
import 'package:plugdin/core/field_validators.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/cubit.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/focus_handler.dart';
import 'package:plugdin/utils/helpers/toast_helper.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/custom_dropdown.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class VendorSignupScreen extends StatefulWidget {
  VendorSignupScreen({super.key});

  @override
  State<VendorSignupScreen> createState() => _VendorSignupScreenState();
}

class _VendorSignupScreenState extends State<VendorSignupScreen> {
  final PageController _pageController = PageController();

  /// Page 1 controllers
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  /// Page 2 controllers
  final TextEditingController _personNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _businessDescriptionController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _pageController.dispose();
    _companyNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) =>
          previous.vendorEmailSignUp != current.vendorEmailSignUp,
      listener: (context, state) {
        if (state.vendorEmailSignUp.isLoaded) {
          ToastHelper.showSuccessToast(
            'Sign up successful!',
          );
        } else if (state.vendorEmailSignUp.isFailure) {
          ToastHelper.showErrorToast(
            state.vendorEmailSignUp.errorMessage ??
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
          body: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              return PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  context.read<OnboardingCubit>().setCurrentPage(index);
                },
                itemCount: 2,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          index == 0
                              ? 'Enter Your Details'
                              : 'Additional Information',
                          style: context.h1,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          index == 0
                              ? 'This is what will be shown on your profile. Make sure to use your authentic details to help us create a trustworthy community.'
                              : 'Please provide additional information to complete your vendor registration.',
                          style: context.b2.copyWith(
                            color: AppColors.darkGreyTextColor,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        if (index == 0) ...[
                          PITextField(
                            hintText: 'Company Name',
                            controller: _companyNameController,
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
                        ] else ...[
                          Column(
                            children: [
                              PITextField(
                                hintText: 'Person Name',
                                controller: _personNameController,
                                validator: FieldValidators.nameValidator,
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
                              PIDropdown<City>(
                                value: state.selectedCity,
                                hintText: 'Select City',
                                items: City.values.map((city) {
                                  return DropdownItem<City>(
                                    value: city,
                                    label: city.toDisplayName(),
                                  );
                                }).toList(),
                                onChanged: (city) {
                                  context
                                      .read<OnboardingCubit>()
                                      .setSelectedCity(city);
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              PITextField(
                                hintText: 'Phone Number',
                                controller: _phoneController,
                                validator: FieldValidators.notNull,
                                type: PITextFieldType.number,
                              ),
                              const SizedBox(
                                height: 16,
                              ),

                              PIDropdown<CategoryType>(
                                value: state.selectedPrimaryCategory,
                                hintText: 'Primary Category',
                                items: CategoryType.values.map((category) {
                                  return DropdownItem<CategoryType>(
                                    value: category,
                                    label: category.toDisplayName(),
                                  );
                                }).toList(),
                                onChanged: (category) {
                                  context
                                      .read<OnboardingCubit>()
                                      .setSelectedPrimaryCategory(category);
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),

                              PIDropdown<CategoryType>(
                                value: state.selectedAdditionalCategory,
                                hintText: 'Additional Category',
                                items: CategoryType.values.map((category) {
                                  return DropdownItem<CategoryType>(
                                    value: category,
                                    label: category.toDisplayName(),
                                  );
                                }).toList(),
                                onChanged: (category) {
                                  context
                                      .read<OnboardingCubit>()
                                      .setSelectedAdditionalCategory(category);
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              PITextField(
                                hintText: 'Paste link here',
                                controller: _linkController,
                              ),
                              const SizedBox(
                                height: 16,
                              ),

                              PITextField(
                                hintText: 'Business Description',
                                controller: _businessDescriptionController,
                                type: PITextFieldType.description,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  );
                },
              );
            },
          ),
          bottomNavigationBar: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              return SafeArea(
                child: PIButton(
                  text: state.currentPage == 0 ? 'Next' : 'Send Request',
                  onPressed: () {
                    if (state.currentPage == 0) {
                      context.read<OnboardingCubit>().nextPage();
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      context.read<OnboardingCubit>().vendorEmailSignUp(
                        name: _personNameController.text,
                        username: _userNameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        companyName: _companyNameController.text,
                        personName: _personNameController.text,
                        address: _addressController.text,
                        city: state.selectedCity?.toDisplayName() ?? '',
                        phoneNumber: _phoneController.text,
                        primaryCategory:
                            state.selectedPrimaryCategory?.toDisplayName() ??
                            '',
                        businessDescription:
                            _businessDescriptionController.text,
                        additionalCategories:
                            state.selectedAdditionalCategory != null
                            ? [
                                state.selectedAdditionalCategory!
                                    .toDisplayName(),
                              ]
                            : null,
                        links: _linkController.text.isNotEmpty
                            ? [_linkController.text]
                            : null,
                      );
                    }
                  },
                  isLoading: state.vendorEmailSignUp.isLoading,
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
