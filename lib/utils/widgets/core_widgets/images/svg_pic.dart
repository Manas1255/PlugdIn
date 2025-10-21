import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PISvgPic extends StatelessWidget {
  const PISvgPic(
    this.path, {
    super.key,
    this.color,
    this.width,
    this.height,
  });
  final String path;
  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      colorFilter: color != null
          ? ColorFilter.mode(
              color!,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
