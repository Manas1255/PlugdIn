import 'dart:ui';
import 'package:flutter/cupertino.dart';

class BlurryBackground extends StatelessWidget {
  const BlurryBackground({
    required this.child,
    super.key,
    this.sigmaX,
    this.sigmaY,
  });
  final Widget child;
  final double? sigmaX;
  final double? sigmaY;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigmaX ?? 1.8, sigmaY: sigmaX ?? 1.8),
      child: child,
    );
  }
}
