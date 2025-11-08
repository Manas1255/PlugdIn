import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/asset_paths.dart';

class PictureUploadWidget extends StatelessWidget {
  const PictureUploadWidget({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppColors.lightGreyColor,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              AssetPaths.unselectedCustomerIcon,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: InkWell(
              onTap: onTap,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(8),
                  child: SvgPicture.asset(
                    AssetPaths.uploadImageIcon,
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
