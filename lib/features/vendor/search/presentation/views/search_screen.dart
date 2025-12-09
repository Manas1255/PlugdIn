import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/features/vendor/filter/presentation/views/filter_bottom_sheet.dart';
import 'package:plugdin/utils/widgets/core_widgets/export.dart';

class VendorSearchScreen extends StatelessWidget {
  VendorSearchScreen({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: PITextField(
                    controller: controller,
                    hintText: 'Search',
                  ),
                ),

                const SizedBox(width: 16),

                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<dynamic>(
                      backgroundColor: AppColors.primaryColor,
                      isScrollControlled: true,
                      useRootNavigator: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),
                      builder: (context) {
                        return const FilterBottomSheet();
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    AssetPaths.filterIcon,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
