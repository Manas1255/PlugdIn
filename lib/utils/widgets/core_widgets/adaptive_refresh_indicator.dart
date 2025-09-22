import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_colors.dart';

class AdaptiveRefreshIndicator extends StatelessWidget {
  const AdaptiveRefreshIndicator({
    required this.onRefresh,
    required this.child,
    super.key,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 2.0,
    this.displacement = 40.0,
    this.edgeOffset = 0.0,
  });

  final Future<void> Function() onRefresh;
  final Widget child;
  final Color? color;
  final Color? backgroundColor;
  final double strokeWidth;
  final double displacement;
  final double edgeOffset;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return _buildIOSRefreshControl(context);
    } else {
      return _buildAndroidRefreshIndicator(context);
    }
  }

  Widget _buildIOSRefreshControl(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: onRefresh,
          builder:
              (
                context,
                refreshState,
                pulledExtent,
                refreshTriggerPullDistance,
                refreshIndicatorExtent,
              ) {
                return Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        color ?? AppColors.primaryColor,
                      ),
                      strokeWidth: strokeWidth,
                    ),
                  ),
                );
              },
        ),
        SliverToBoxAdapter(child: child),
      ],
    );
  }

  Widget _buildAndroidRefreshIndicator(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color ?? AppColors.primaryColor,
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      strokeWidth: strokeWidth,
      displacement: displacement,
      edgeOffset: edgeOffset,
      child: child,
    );
  }
}

class AdaptiveRefreshIndicatorWrapper extends StatelessWidget {
  const AdaptiveRefreshIndicatorWrapper({
    required this.onRefresh,
    required this.child,
    super.key,
    this.color,
    this.backgroundColor,
    this.strokeWidth = 2.0,
    this.displacement = 40.0,
    this.edgeOffset = 0.0,
  });

  final Future<void> Function() onRefresh;
  final Widget child;
  final Color? color;
  final Color? backgroundColor;
  final double strokeWidth;
  final double displacement;
  final double edgeOffset;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: onRefresh,
      color: color ?? AppColors.primaryColor,
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
      strokeWidth: strokeWidth,
      displacement: displacement,
      edgeOffset: edgeOffset,
      child: child,
    );
  }
}
