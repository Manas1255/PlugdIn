import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';

class PIBottomSheet extends StatefulWidget {
  const PIBottomSheet({
    required this.title,
    required this.text,
    required this.buttonText,
    required this.onTap,
    super.key,
  });
  final String title;
  final String text;
  final String buttonText;
  final VoidCallback onTap;

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String text,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    return showModalBottomSheet(
      useRootNavigator: true,
      backgroundColor: AppColors.white,
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxWidth: screenWidth,
        minWidth: screenWidth,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) => PIBottomSheet(
        title: title,
        text: text,
        buttonText: buttonText,
        onTap: onTap,
      ),
    );
  }

  @override
  State<PIBottomSheet> createState() => _PIBottomSheetState();
}

class _PIBottomSheetState extends State<PIBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.26,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: context.h3.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.text,
                  style: context.b2.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                PIButton(
                  text: widget.buttonText,
                  onPressed: widget.onTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
