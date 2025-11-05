import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/core/app_preferences/app_preferences.dart';
import 'package:plugdin/core/di/injector.dart';
import 'package:plugdin/go_router/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      final prefs = Injector.resolve<AppPreferences>();
      final token = prefs.getToken();

      if (!mounted) return;

      if (token != null && token.isNotEmpty) {
        if (!mounted) return;
        // Check if vendor model exists to determine which navigation to use
        final vendorModel = prefs.getVendorModel();
        final customerModel = prefs.getUserModel();
        
        if (vendorModel != null) {
          context.goNamed(AppRouteNames.vendorHomeScreen);
        } else if (customerModel != null) {
          context.goNamed(AppRouteNames.customerHomeScreen);
        } else {
          // No model found, go to onboarding
          context.goNamed(AppRouteNames.onboarding);
        }
      } else {
        context.goNamed(AppRouteNames.onboarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'R.',
          style: context.h1,
        ),
      ),
    );
  }
}
