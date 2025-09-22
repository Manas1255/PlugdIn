import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';

class FitThereDialogWidget extends StatelessWidget {
  const FitThereDialogWidget({
    required this.optionOneText,
    required this.headingText,
    required this.optionTwoText,
    required this.subHeadingText,
    required this.onOptionOneTextPress,
    required this.onOptionTwoTextPress,
    super.key,
  });

  final String headingText;
  final String subHeadingText;
  final String optionOneText;
  final String optionTwoText;
  final VoidCallback onOptionOneTextPress;
  final VoidCallback onOptionTwoTextPress;

  static Future<void> show(
    BuildContext context, {
    required String headingText,
    required String subHeadingText,
    required String optionOneText,
    required String optionTwoText,
    required VoidCallback onOptionOneTextPress,
    required VoidCallback onOptionTwoTextPress,
  }) {
    return showDialog(
      context: context,
      builder: (_) => FitThereDialogWidget(
        headingText: headingText,
        subHeadingText: subHeadingText,
        optionOneText: optionOneText,
        optionTwoText: optionTwoText,
        onOptionOneTextPress: () {
          context.pop();
          onOptionOneTextPress();
        },
        onOptionTwoTextPress: () {
          context.pop();
          onOptionTwoTextPress();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 20,
              start: 16,
              end: 16,
            ),
            child: Column(
              children: [
                Text(
                  headingText,
                  style: context.b1.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subHeadingText,
                  style: context.l2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          Divider(
            height: 0.33,
            color: AppColors.lightGreyShade3.withValues(alpha: 0.55),
          ),
          Row(
            children: [
              Expanded(
                child: PIButton(
                  onPressed: onOptionOneTextPress,
                  text: optionOneText,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black,
                  backgroundColor: AppColors.primaryColor,
                  splashColor: Colors.transparent,
                  isExpanded: false,
                ),
              ),
              Container(
                width: 0.33,
                height: 56,
                color: AppColors.lightGreyShade3.withValues(alpha: 0.55),
              ),
              Expanded(
                child: PIButton(
                  onPressed: onOptionTwoTextPress,
                  text: optionTwoText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.black,
                  backgroundColor: AppColors.primaryColor,
                  splashColor: Colors.transparent,
                  isExpanded: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
