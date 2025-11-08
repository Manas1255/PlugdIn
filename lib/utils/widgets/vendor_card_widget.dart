import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_constants.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class VendorCardWidget extends StatelessWidget {
  const VendorCardWidget({
    required this.companyName,
    required this.primaryCategory,
    required this.location,
    super.key,
  });

  final String companyName;
  final String primaryCategory;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          20,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(
              alpha: 0.25,
            ),
            blurRadius: 6,
          ),
        ],
      ),
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PICNIWidget(
            imageUrl: AppConstants.dummyVendorCoverImage,
            height: 125,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 8),
          Text(
            companyName,
            style: context.h2.copyWith(
              fontSize: 24,
            ),
          ),
          Text(
            primaryCategory,
            style: context.l3.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            location,
            style: context.l3.copyWith(
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}
