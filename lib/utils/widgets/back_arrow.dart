import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/asset_paths.dart';

class BackArrowIcon extends StatelessWidget {
  const BackArrowIcon({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.white,
        ),
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          AssetPaths.backIcon,
        ),
        onPressed: onTap,
      ),
    );
  }
}
