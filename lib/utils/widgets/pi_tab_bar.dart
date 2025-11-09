import 'package:flutter/cupertino.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';

class PITabBar extends StatelessWidget {
  const PITabBar({
    required this.tabOneText,
    required this.tabTwoText,
    required this.onTabOnePress,
    required this.onTabTwoPress,
    required this.selectedIndex,
    required this.tabThreeText,
    required this.onTabThreePress,
    required this.tabFourText,
    required this.onTabFourPress,
    super.key,
  });

  final String tabOneText;
  final String tabTwoText;
  final String tabThreeText;
  final String tabFourText;
  final VoidCallback onTabOnePress;
  final VoidCallback onTabTwoPress;
  final VoidCallback onTabThreePress;
  final VoidCallback onTabFourPress;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = constraints.maxWidth / 4;

          return Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 4,
                  color: AppColors.lightGreyColor,
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.ease,
                bottom: 0,
                left: tabWidth * selectedIndex,
                child: Container(
                  height: 4,
                  width: tabWidth,
                  color: AppColors.secondaryColor,
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
                                ? AppColors.secondaryColor
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
                                ? AppColors.secondaryColor
                                : AppColors.darkGreyTextColor,
                            fontWeight: selectedIndex == 1
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: onTabThreePress,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          tabThreeText,
                          textAlign: TextAlign.center,
                          style: context.b2.copyWith(
                            color: selectedIndex == 2
                                ? AppColors.secondaryColor
                                : AppColors.darkGreyTextColor,
                            fontWeight: selectedIndex == 2
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: onTabFourPress,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          tabFourText,
                          textAlign: TextAlign.center,
                          style: context.b2.copyWith(
                            color: selectedIndex == 3
                                ? AppColors.secondaryColor
                                : AppColors.darkGreyTextColor,
                            fontWeight: selectedIndex == 3
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
          );
        },
      ),
    );
  }
}
