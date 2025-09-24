import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';

class RoleSelectionWidget extends StatelessWidget {
  const RoleSelectionWidget({
    required this.title,
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
    super.key,
  });
  final String title;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (MediaQuery.sizeOf(context).width - 48) / 2,
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: 32,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: isSelected ? AppColors.secondaryColor : AppColors.grey,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(
            32,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.h3.copyWith(
                color: isSelected ? AppColors.secondaryColor : AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
