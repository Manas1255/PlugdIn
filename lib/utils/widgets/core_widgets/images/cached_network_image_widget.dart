import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plugdin/generated/assets.dart';
import 'package:plugdin/utils/widgets/core_widgets/shimmer_effect.dart';

class FitThereCNIWidget extends StatelessWidget {
  const FitThereCNIWidget({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.useShimmer = true,
    super.key,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool useShimmer;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      imageBuilder: (context, imageProvider) =>
          _buildLoadedImage(imageProvider),
      placeholder: (context, url) => _buildLoadingWidget(),
      errorWidget: (context, url, error) => _buildErrorWidget(),
    );

    if (borderRadius != null) {
      imageWidget = ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildLoadedImage(ImageProvider imageProvider) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: fit,
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    if (placeholder != null) return placeholder!;

    final Widget loadingContainer = Container(
      width: width,
      height: height,
      color: Colors.grey[200],
    );

    if (useShimmer) {
      return CustomShimmerEffect(child: loadingContainer);
    }

    return loadingContainer;
  }

  Widget _buildErrorWidget() {
    if (errorWidget != null) return errorWidget!;

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.asset(
        Assets.imagesErrorPlaceholderImage,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}
