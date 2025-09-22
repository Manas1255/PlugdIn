import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';

PreferredSizeWidget reStyleAppBar({
  required BuildContext context,
  required String title,
  VoidCallback? onLeadingPressed,
  String? actionText,
  TextStyle? titleStyle,
  TextStyle? actionTextStyle,
  Widget? actionWidget,
  double elevation = 0.0,
  bool forceMaterialTransparency = true,
  bool centerTitle = false,
  double titleSpacing = 16.0,
  Widget? leadingIcon,
  bool showLeading = true,
  double actionsPadding = 16,
  Color? backgroundColor,
  double? height,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(height ?? 80),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: AppBar(
        backgroundColor: backgroundColor ?? Colors.transparent,
        elevation: elevation,
        centerTitle: centerTitle,
        titleSpacing: titleSpacing,
        leadingWidth: 64,
        toolbarHeight: height ?? 80,
        automaticallyImplyLeading: showLeading,
        leading: leadingIcon != null
            ? IconButton(
                enableFeedback: false,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                onPressed: onLeadingPressed,
                icon: leadingIcon,
                color: AppColors.offWhite,
              )
            : null,
        title: Text(
          title,
          style: titleStyle ?? context.t2,
        ),
        actions: actionText != null
            ? [
                Text(
                  actionText,
                  style: actionTextStyle ?? context.b2,
                ),
                const SizedBox(width: 16),
              ]
            : actionWidget != null
            ? [
                actionWidget,
                SizedBox(width: actionsPadding),
              ]
            : [],
      ),
    ),
  );
}
