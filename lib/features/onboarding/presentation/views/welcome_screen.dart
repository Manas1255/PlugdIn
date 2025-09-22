import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 32),
        child: Column(
          children: [
            Image.asset(
              AssetPaths.appLogo,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Your event, your way, we’ll connect you with the best.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: PIButton.secondary(
          text: 'Login',
          onPressed: () {},
          outsidePadding: const EdgeInsetsDirectional.symmetric(
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
