import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';

class VendorOnboardingSuccessScreen extends StatelessWidget {
  const VendorOnboardingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(62),
                decoration: const BoxDecoration(
                  color: AppColors.secondaryColor,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AssetPaths.tickIcon,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                'Request Sent',
                style: context.h1.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Thank you for registering on PludgIn!  Your request has been submitted successfully. You’ll receive an update via email within 5 working days once your request is reviewed and accepted.',
                style: context.b2.copyWith(
                  color: AppColors.lightGreyShade2,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: PIButton(
          text: 'Done',
          onPressed: () {
            context.goNamed(
              AppRouteNames.onboarding,
            );
          },
          outsidePadding: const EdgeInsetsDirectional.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
        ),
      ),
    );
  }
}
