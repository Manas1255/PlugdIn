import 'package:flutter/cupertino.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';
import 'package:plugdin/utils/widgets/core_widgets/images/svg_pic.dart';

class PIErrorWidget extends StatelessWidget {
  const PIErrorWidget({
    required this.onPressed,
    this.errorText = 'Could not fetch data!',
    super.key,
    this.errorIcon = AssetPaths.flagIcon,
  });

  final String errorText;
  final String errorIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PISvgPic(errorIcon),
          const SizedBox(
            height: 8,
          ),
          Text(
            errorText,
            style: context.b2,
          ),
          const SizedBox(
            height: 8,
          ),

          PIButton(
            text: 'Retry',
            onPressed: onPressed,

            borderColor: AppColors.primaryColor,
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
