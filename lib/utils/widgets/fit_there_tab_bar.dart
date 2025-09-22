import 'package:flutter/cupertino.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';

class FTTabBar extends StatelessWidget {
  const FTTabBar({
    required this.tabOneText,
    required this.tabTwoText,
    required this.onTabOnePress,
    required this.onTabTwoPress,
    required this.selectedIndex,
    super.key,
  });

  final String tabOneText;
  final String tabTwoText;
  final VoidCallback onTabOnePress;
  final VoidCallback onTabTwoPress;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 4,
                    color: AppColors.lightGreyColor,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 4,
                    color: AppColors.lightGreyColor,
                  ),
                ),
              ],
            ),
          ),
          AnimatedAlign(
            alignment: selectedIndex == 0
                ? Alignment.bottomLeft
                : Alignment.bottomRight,
            duration: const Duration(milliseconds: 250),
            curve: Curves.ease,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                height: 4,
                color: AppColors.black,
              ),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onTabOnePress,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      tabOneText,
                      textAlign: TextAlign.center,
                      style: context.b2.copyWith(
                        color: selectedIndex == 0
                            ? AppColors.black
                            : AppColors.darkGreyTextColor,
                        fontWeight: selectedIndex == 0
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onTabTwoPress,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      tabTwoText,
                      textAlign: TextAlign.center,
                      style: context.b2.copyWith(
                        color: selectedIndex == 1
                            ? AppColors.black
                            : AppColors.darkGreyTextColor,
                        fontWeight: selectedIndex == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
