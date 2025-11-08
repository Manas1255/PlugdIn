import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';

class PIFilterChipWidget extends StatelessWidget {
  const PIFilterChipWidget({
    required this.label,
    required this.onTap,
    this.isSelected = false,
    super.key,
  });

  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isSelected
        ? AppColors.secondaryColor
        : AppColors.white;
    final borderColor = isSelected ? AppColors.secondaryColor : AppColors.grey;
    final textColor = isSelected ? AppColors.white : AppColors.grey;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: borderColor,
            width: 1.15,
          ),
        ),
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Text(
          label,
          style: context.l2.copyWith(
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
