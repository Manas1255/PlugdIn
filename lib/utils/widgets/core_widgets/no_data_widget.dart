import 'package:flutter/cupertino.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';
import 'package:plugdin/utils/widgets/core_widgets/images/svg_pic.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    required this.text,
    super.key,
    this.icon = AssetPaths.flagIcon,
    this.buttonText,
    this.onTap,
  });
  final String text;
  final String icon;
  final String? buttonText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PISvgPic(icon),
          const SizedBox(
            height: 8,
          ),
          Text(
            text,
            style: context.b2,
          ),
          const SizedBox(
            height: 8,
          ),

          if (buttonText != null && buttonText!.trim().isNotEmpty)
            PIButton(
              text: buttonText!,
              onPressed: onTap,
              isExpanded: false,
              padding: const EdgeInsetsDirectional.symmetric(
                vertical: 6,
                horizontal: 14,
              ),
            ),
        ],
      ),
    );
  }
}
