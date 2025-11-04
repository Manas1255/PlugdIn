import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plugdin/constants/app_text_style.dart';

class SettingsTileWidget extends StatelessWidget {
  const SettingsTileWidget({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });
  final String icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: context.b2,
          ),
        ],
      ),
    );
  }
}
