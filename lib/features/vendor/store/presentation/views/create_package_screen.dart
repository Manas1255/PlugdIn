import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/features/vendor/store/data/models/create_package_request_model.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
import 'package:plugdin/utils/helpers/toast_helper.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';
import 'package:plugdin/utils/widgets/core_widgets/text_field.dart';
import 'package:plugdin/utils/widgets/image_picker_bottom_sheet.dart';

class CreatePackageScreen extends StatefulWidget {
  const CreatePackageScreen({super.key});

  @override
  State<CreatePackageScreen> createState() => _CreatePackageScreenState();
}

class _CreatePackageScreenState extends State<CreatePackageScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _subpriceController = TextEditingController();
  final _totalPriceController = TextEditingController();
  final List<TextEditingController> _vendorEmailControllers = [];
  final List<File?> _selectedFiles = [];

  @override
  void initState() {
    super.initState();
    context.read<VendorStoreCubit>().resetCreatePackageState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _subpriceController.dispose();
    _totalPriceController.dispose();
    for (final controller in _vendorEmailControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addVendorEmailField() {
    setState(() {
      _vendorEmailControllers.add(TextEditingController());
    });
  }

  void _removeVendorEmailField(int index) {
    setState(() {
      _vendorEmailControllers[index].dispose();
      _vendorEmailControllers.removeAt(index);
    });
  }

  void _addFileField() {
    setState(() {
      _selectedFiles.add(null);
    });
  }

  void _removeFileField(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
  }

  Future<void> _showImagePickerBottomSheet(int index) async {
    await ImagePickerBottomSheet.show(
      context,
      onCameraTap: () async {
        Navigator.of(context, rootNavigator: true).pop();
        await context.read<VendorStoreCubit>().pickStoreImageFromCamera();
        _setSelectedFile(index);
      },
      onGalleryTap: () async {
        Navigator.of(context, rootNavigator: true).pop();
        await context.read<VendorStoreCubit>().pickStoreImageFromGallery();
        _setSelectedFile(index);
      },
    );
  }

  void _setSelectedFile(int index) {
    final state = context.read<VendorStoreCubit>().state;
    if (state.storeImageFile != null) {
      setState(() {
        _selectedFiles[index] = state.storeImageFile;
      });

      context.read<VendorStoreCubit>().clearStoreImage();
    }
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final vendorEmails = _vendorEmailControllers
          .map((controller) => controller.text.trim())
          .where((email) => email.isNotEmpty)
          .toList();

      final files = _selectedFiles
          .where((file) => file != null)
          .map((file) => file!.path)
          .toList();

      final package = CreatePackageRequestModel(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        subprice: int.tryParse(_subpriceController.text.trim()) ?? 0,
        totalPrice: int.tryParse(_totalPriceController.text.trim()) ?? 0,
        vendorEmails: vendorEmails,
        files: files,
      );

      context.read<VendorStoreCubit>().createPackage(package);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: BackArrowIcon(
          onTap: () {
            context.pop();
          },
        ),
        title: Text(
          'Create Package',
          style: context.h3,
        ),
      ),
      body: BlocListener<VendorStoreCubit, VendorStoreState>(
        listenWhen: (previous, current) =>
            previous.createPackageState != current.createPackageState,
        listener: (context, state) {
          if (state.createPackageState.isLoaded) {
            ToastHelper.showSuccessToast(
              state.createPackageState.data?.message ??
                  'Package created successfully',
            );
            context.pop();
          } else if (state.createPackageState.isFailure) {
            ToastHelper.showErrorToast(
              state.createPackageState.errorMessage ??
                  'Failed to create package',
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PITextField(
                  controller: _titleController,
                  labelText: 'Title',
                  hintText: 'Enter package title',
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                PITextField(
                  controller: _descriptionController,
                  labelText: 'Description',
                  hintText: 'Enter package description',
                  type: PITextFieldType.description,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                PITextField(
                  controller: _subpriceController,
                  labelText: 'Subprice',
                  hintText: 'Enter subprice',
                  type: PITextFieldType.number,
                  textInputType: TextInputType.number,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Subprice is required';
                    }
                    if (int.tryParse(value.trim()) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                PITextField(
                  controller: _totalPriceController,
                  labelText: 'Total Price',
                  hintText: 'Enter total price',
                  type: PITextFieldType.number,
                  textInputType: TextInputType.number,
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Total price is required';
                    }
                    if (int.tryParse(value.trim()) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Vendor Emails',
                      style: context.b1.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: _addVendorEmailField,
                      child: Text(
                        'Add Email',
                        style: context.b2.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...List.generate(
                  _vendorEmailControllers.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: PITextField(
                            controller: _vendorEmailControllers[index],
                            labelText: 'Vendor Email ${index + 1}',
                            hintText: 'Enter vendor email',
                            type: PITextFieldType.email,
                            validator: (value) {
                              if (value != null &&
                                  value.trim().isNotEmpty &&
                                  !value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () => _removeVendorEmailField(index),
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            color: AppColors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Files',
                      style: context.b1.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: _addFileField,
                      child: Text(
                        'Add File',
                        style: context.b2.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...List.generate(
                  _selectedFiles.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _selectedFiles[index] != null
                        ? Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.lightGreyShade3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _selectedFiles[index]!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'File ${index + 1}',
                                    style: context.b2,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _removeFileField(index),
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    color: AppColors.red,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.lightGreyShade3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'File ${index + 1}',
                                    style: context.b2.copyWith(
                                      color: AppColors.lightGreyShade2,
                                    ),
                                  ),
                                ),
                                PIButton(
                                  text: 'Choose File',
                                  onPressed: () =>
                                      _showImagePickerBottomSheet(index),
                                  isExpanded: false,
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                  fontSize: 12,
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: () => _removeFileField(index),
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    color: AppColors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<VendorStoreCubit, VendorStoreState>(
        builder: (context, state) {
          return SafeArea(
            child: PIButton(
              text: 'Create Package',
              onPressed: _submitForm,
              isLoading: state.createPackageState.isLoading,
              outsidePadding: const EdgeInsetsDirectional.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
            ),
          );
        },
      ),
    );
  }
}
