import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/utils/widgets/core_widgets/blurry_background.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';
import 'package:plugdin/utils/widgets/core_widgets/images/svg_pic.dart';

class ReStyleBottomSheet extends StatelessWidget {
  const ReStyleBottomSheet.showSheet({
    required this.title,
    this.onTap,
    this.imagePath,
    this.imageColor,
    this.buttonText,
    this.subtitle,
    this.richTextWidget,
    this.showTwoButtons = false,
    this.buttonOneText,
    this.buttonTwoText,
    this.buttonOneOnTap,
    this.buttonTwoOnTap,
    this.buttonOneColor,
    this.buttonTwoColor,
    this.buttonOnePrefix,
    this.buttonTwoPrefix,
    this.buttonTwoIsLoading = false,
    this.isLoading = false,
    this.buttonColor = AppColors.primaryColor,
    this.textBelowButton,
    this.onTapTextBelowButton,
    this.titleAlignment,
    this.bodyWidget,
    this.noteText,
    this.height,
    super.key,
    this.buttonOneBorderColor,
    this.buttonTwoBorderColor,
  });

  final String? imagePath;
  final Color? imageColor;
  final String title;
  final String? subtitle;
  final Widget? richTextWidget;
  final String? buttonText;
  final VoidCallback? onTap;
  final bool isLoading;
  final Color buttonColor;
  final String? textBelowButton;
  final VoidCallback? onTapTextBelowButton;
  final Widget? bodyWidget;
  final bool showTwoButtons;
  final String? buttonOneText;
  final String? buttonTwoText;
  final VoidCallback? buttonOneOnTap;
  final VoidCallback? buttonTwoOnTap;
  final Color? buttonOneColor;
  final Color? buttonTwoColor;
  final Color? buttonOneBorderColor;
  final Color? buttonTwoBorderColor;
  final Widget? buttonOnePrefix;
  final Widget? buttonTwoPrefix;
  final TextAlign? titleAlignment;
  final bool buttonTwoIsLoading;
  final String? noteText;

  final double? height;

  static void show({
    required BuildContext context,
    required String title,
    String? imagePath,
    Color? imageColor,
    String? buttonText,
    VoidCallback? onTap,
    String? subtitle,
    Widget? richTextWidget,
    bool isLoading = false,
    Color buttonColor = AppColors.primaryColor,
    String? textBelowButton,
    VoidCallback? onTapTextBelowButton,
    bool showTwoButtons = false,
    String? buttonOneText,
    String? buttonTwoText,
    VoidCallback? buttonOneOnTap,
    VoidCallback? buttonTwoOnTap,
    Color? buttonOneColor,
    Color? buttonTwoColor,
    Widget? buttonOnePrefix,
    Widget? buttonTwoPrefix,
    TextAlign? titleAlignment,
    Widget? bodyWidget,
    bool buttonTwoIsLoading = false,
    String? noteText,
    double? height,
    Color? buttonOneBorderColor,
    Color? buttonTwoBorderColor,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: AppColors.tertiaryShade2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: (context) {
        Widget sheet = SizedBox(
          height: height != null
              ? MediaQuery.of(context).size.height * height
              : null,
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: ReStyleBottomSheet.showSheet(
              imagePath: imagePath,
              imageColor: imageColor,
              title: title,
              subtitle: subtitle,
              richTextWidget: richTextWidget,
              buttonText: buttonText,
              onTap: onTap,
              isLoading: isLoading,
              buttonColor: buttonColor,
              textBelowButton: textBelowButton,
              onTapTextBelowButton: onTapTextBelowButton,
              showTwoButtons: showTwoButtons,
              buttonOneText: buttonOneText,
              buttonTwoText: buttonTwoText,
              buttonOneOnTap: buttonOneOnTap,
              buttonTwoOnTap: buttonTwoOnTap,
              buttonOneColor: buttonOneColor,
              buttonTwoColor: buttonTwoColor,
              buttonOnePrefix: buttonOnePrefix,
              buttonTwoPrefix: buttonTwoPrefix,
              titleAlignment: titleAlignment,
              bodyWidget: bodyWidget,
              buttonTwoIsLoading: buttonTwoIsLoading,
              noteText: noteText,
            ),
          ),
        );
        if (!isDismissible) {
          sheet = PopScope(
            canPop: false,
            child: sheet,
          );
        }
        return sheet;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlurryBackground(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 3,
              width: 64,
              decoration: BoxDecoration(
                color: AppColors.swipeTextGrey,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 30),
            if (imagePath != null)
              FitThereSvgPic(
                imagePath!,
                height: 100,
                color: imageColor,
              ),
            const SizedBox(height: 29),
            Text(
              title,
              style: context.t1.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: titleAlignment,
            ),
            const SizedBox(height: 12),
            if (richTextWidget != null)
              richTextWidget!
            else if (subtitle != null)
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: context.b2.copyWith(
                  color: AppColors.bottomSheetSubtitle,
                ),
              ),
            if (noteText != null)
              Text(
                noteText!,
                textAlign: TextAlign.center,
                style: context.h1.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            if (bodyWidget != null) bodyWidget!,
            if (showTwoButtons) ...[
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: FitThereButton(
                      prefixIcon: buttonOnePrefix,
                      text: buttonOneText ?? '',
                      borderColor:
                          buttonOneBorderColor ?? AppColors.bottomSheetBorder,
                      onPressed: buttonOneOnTap,
                      isLoading: isLoading,
                      backgroundColor: buttonOneColor ?? AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FitThereButton(
                      prefixIcon: buttonTwoPrefix,
                      text: buttonTwoText ?? '',
                      borderColor:
                          buttonTwoBorderColor ?? AppColors.bottomSheetBorder,
                      onPressed: buttonTwoOnTap,
                      isLoading: buttonTwoIsLoading,
                      backgroundColor: buttonTwoColor ?? AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ] else if (buttonText != null) ...[
              FitThereButton(
                text: buttonText!,
                onPressed: onTap,
                isLoading: isLoading,
                backgroundColor: buttonColor,
              ),
            ],
            if (textBelowButton != null) ...[
              const SizedBox(height: 16),
              GestureDetector(
                onTap: onTapTextBelowButton,
                child: Text(
                  textBelowButton ?? '',
                  style: context.b2.copyWith(
                    color: AppColors.darkGreyTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }
}
