import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';

class PackagesView extends StatelessWidget {
  const PackagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Packages view',
          style: context.b2,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: PIButton(
          text: 'Create Your Package',
          onPressed: () {
            context.pushNamed(
              AppRouteNames.createPackageScreen,
            );
          },
          outsidePadding: const EdgeInsetsDirectional.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
