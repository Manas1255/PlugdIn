import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.size = 24,
    this.color = AppColors.black,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(color),
          backgroundColor: Platform.isIOS ? AppColors.black : null,
          strokeWidth: 1.5,
        ),
      ),
    );
  }
}
