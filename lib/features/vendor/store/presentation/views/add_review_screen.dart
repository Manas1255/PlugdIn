import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/features/vendor/store/data/models/add_review_request_model.dart';
import 'package:plugdin/features/vendor/store/data/models/package_model.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/cubit.dart';
import 'package:plugdin/features/vendor/store/presentation/cubit/state.dart';
import 'package:plugdin/features/vendor/store/presentation/widgets/star_rating_widget.dart';
import 'package:plugdin/utils/helpers/toast_helper.dart';
import 'package:plugdin/utils/widgets/back_arrow.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';
import 'package:plugdin/utils/widgets/core_widgets/text_field.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({
    required this.package,
    super.key,
  });

  final PackageModel package;

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reviewController = TextEditingController();
  double _rating = 0.0;

  @override
  void initState() {
    super.initState();
    context.read<VendorStoreCubit>().resetAddReviewState();
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _submitReview() {
    if (_formKey.currentState!.validate()) {
      if (_rating == 0.0) {
        ToastHelper.showSuccessToast('Please select a rating');
        return;
      }

      final vendorId = widget.package.creatorVendorId.id;
      if (vendorId.isEmpty) {
        ToastHelper.showErrorToast('Invalid vendor information');
        return;
      }

      final reviewRequest = AddReviewRequestModel(
        vendorId: vendorId,
        packageId: widget.package.id,
        review: _reviewController.text.trim(),
        rating: _rating,
      );

      context.read<VendorStoreCubit>().addReview(reviewRequest);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VendorStoreCubit, VendorStoreState>(
      listener: (context, state) {
        if (state.addReviewState.isLoaded) {
          ToastHelper.showSuccessToast('Review added successfully');
          context.pop();
        } else if (state.addReviewState.isFailure) {
          ToastHelper.showErrorToast(
            state.addReviewState.errorMessage ?? 'Failed to add review',
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: BackArrowIcon(
            onTap: () {
              context.pop();
            },
          ),
          title: Text(
            'Add Review',
            style: context.h3,
          ),
          centerTitle: false,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Package Info Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.greyShade3,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.package.title,
                        style: context.h3.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.package.description,
                        style: context.l3.copyWith(
                          color: AppColors.darkGrey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Rating Section
                Text(
                  'Rating',
                  style: context.h3.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                StarRatingWidget(
                  initialRating: _rating,
                  onRatingChanged: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
                if (_rating > 0) ...[
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      '${_rating.toStringAsFixed(1)} / 5.0',
                      style: context.b2.copyWith(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                // Review Text Section
                Text(
                  'Your Review',
                  style: context.h3.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                PITextField(
                  controller: _reviewController,
                  type: PITextFieldType.description,
                  hintText: 'Share your experience with this package...',
                  labelText: 'Review',
                  isRequired: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your review';
                    }
                    if (value.trim().length < 10) {
                      return 'Review must be at least 10 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<VendorStoreCubit, VendorStoreState>(
          builder: (context, state) {
            return SafeArea(
              child: PIButton(
                text: 'Submit Review',
                onPressed: _submitReview,
                isLoading: state.addReviewState.isLoading,
                outsidePadding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
