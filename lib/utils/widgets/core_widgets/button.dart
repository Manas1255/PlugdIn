import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/utils/widgets/core_widgets/loading_widget.dart';

class PIButton extends StatelessWidget {
  const PIButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    super.key,
    this.backgroundColor = AppColors.secondaryColor,
    this.textColor = AppColors.white,
    this.disabledTextColor = AppColors.offWhite,
    this.disabledBackgroundColor,
    this.borderRadius = 16,
    this.padding = const EdgeInsetsDirectional.symmetric(
      vertical: 16,
      horizontal: 24,
    ),
    this.fontWeight = FontWeight.w700,
    this.splashColor = Colors.black12,
    this.fontSize = 14,
    this.prefixIcon,
    this.suffixIcon,
    this.outsidePadding = const EdgeInsetsDirectional.symmetric(vertical: 4),
    this.isExpanded = true,
    this.iconSpacing,
    this.disabled = false,
    this.loadingColor = AppColors.white,
    this.borderColor,
    this.borderWidth = 1.0,
  });
  const PIButton.tertiary({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    super.key,
    this.borderRadius = 16,
    this.padding = const EdgeInsetsDirectional.symmetric(
      vertical: 16,
      horizontal: 24,
    ),
    this.fontWeight = FontWeight.w700,
    this.splashColor = Colors.black12,
    this.fontSize = 14,
    this.prefixIcon,
    this.suffixIcon,
    this.outsidePadding = const EdgeInsetsDirectional.symmetric(vertical: 4),
    this.isExpanded = true,
    this.iconSpacing,
    this.disabled = false,
    this.borderWidth = 1.0,
    this.backgroundColor = Colors.transparent,
    this.borderColor = AppColors.offWhite,
  }) : textColor = AppColors.white,
       disabledTextColor = AppColors.black,
       disabledBackgroundColor = AppColors.lightGreyColor,
       loadingColor = AppColors.black;

  PIButton.secondary({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    super.key,
    this.borderRadius = 16,
    this.padding = const EdgeInsetsDirectional.symmetric(
      vertical: 16,
      horizontal: 24,
    ),
    this.fontWeight = FontWeight.w700,
    this.splashColor = Colors.black12,
    this.fontSize = 14,
    this.prefixIcon,
    this.suffixIcon,
    this.outsidePadding = const EdgeInsetsDirectional.symmetric(vertical: 4),
    this.isExpanded = true,
    this.iconSpacing,
    this.disabled = false,
    this.borderColor = AppColors.lightGreyColor,
    this.borderWidth = 1.0,
    this.textColor = AppColors.black,
  }) : backgroundColor = AppColors.white,
       disabledTextColor = AppColors.black,
       disabledBackgroundColor = AppColors.primaryColor,
       loadingColor = AppColors.black;

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsDirectional padding;
  final FontWeight fontWeight;
  final Color splashColor;
  final double fontSize;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsDirectional? outsidePadding;
  final bool isExpanded;
  final double? iconSpacing;
  final bool disabled;
  final Color disabledTextColor;
  final Color? disabledBackgroundColor;
  final Color loadingColor;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final effectiveDisabledBackgroundColor =
        disabledBackgroundColor ?? backgroundColor.withValues(alpha: 0.5);

    final button = TextButton(
      onPressed: (isLoading || disabled) ? null : onPressed,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        backgroundColor: disabled
            ? effectiveDisabledBackgroundColor
            : backgroundColor,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: borderColor != null
              ? BorderSide(
                  color: disabled
                      ? borderColor!.withOpacity(0.5)
                      : borderColor!,
                  width: borderWidth,
                )
              : BorderSide.none,
        ),
        splashFactory: InkRipple.splashFactory,
        overlayColor: splashColor,
      ),
      child: Padding(
        padding: padding,
        child: isLoading
            ? SizedBox(
                height: 26,
                width: 26,
                child: LoadingWidget(
                  color: loadingColor,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    SizedBox(width: iconSpacing ?? 8),
                  ],
                  Text(
                    text,
                    style: context.b3.copyWith(
                      color: disabled ? disabledTextColor : textColor,
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    SizedBox(width: iconSpacing ?? 8),
                    suffixIcon!,
                  ],
                ],
              ),
      ),
    );

    return Padding(
      padding: outsidePadding ?? EdgeInsets.zero,
      child: isExpanded
          ? Row(
              children: [
                Expanded(child: button),
              ],
            )
          : button,
    );
  }
}
