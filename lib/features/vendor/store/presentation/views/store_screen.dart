import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/features/vendor/store/presentation/widgets/store_details_widget.dart';
import 'package:plugdin/features/vendor/store/presentation/widgets/store_header_widget.dart';
import 'package:plugdin/utils/widgets/pi_tab_bar.dart';

class VendorStoreScreen extends StatelessWidget {
  const VendorStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 8,
        shadowColor: AppColors.black.withValues(alpha: 0.25),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
        surfaceTintColor: AppColors.white,
        title: Text(
          '@username',
          style: context.h3.copyWith(
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StoreHeaderWidget(),
            const SizedBox(height: 16),
            StoreDetailsWidget(),
            PITabBar(
              tabOneText: 'Store',
              tabTwoText: 'Details',
              tabThreeText: 'Packages',
              tabFourText: 'Reviews',
              onTabOnePress: () {},
              onTabTwoPress: () {},
              onTabThreePress: () {},
              onTabFourPress: () {},
              selectedIndex: 0,
            ),
          ],
        ),
      ),
    );
  }
}
