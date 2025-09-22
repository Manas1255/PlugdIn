import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plugdin/constants/asset_paths.dart';

class StarRatingWidget extends StatelessWidget {
  const StarRatingWidget({
    required this.rating,
    this.filledStarAsset = AssetPaths.starFilledIcon,
    this.emptyStarAsset = AssetPaths.starOutlinedIcon,
    super.key,
    this.starCount = 5,
    this.size = 20,
  });

  final double rating;
  final int starCount;
  final double size;
  final String filledStarAsset;
  final String emptyStarAsset;

  @override
  Widget build(BuildContext context) {
    final stars = <Widget>[];
    for (var i = 0; i < starCount; i++) {
      final fillPercent = (rating - i).clamp(0, 1);
      if (fillPercent == 1) {
        stars.add(
          _buildStar(filledStarAsset),
        );
      } else if (fillPercent == 0) {
        stars.add(_buildStar(emptyStarAsset));
      } else {
        stars.add(
          SizedBox(
            width: size,
            height: size,
            child: Stack(
              children: [
                _buildStar(emptyStarAsset),
                ClipRect(
                  clipper: _StarClipper(fillPercent.toDouble()),
                  child: _buildStar(filledStarAsset),
                ),
              ],
            ),
          ),
        );
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }

  Widget _buildStar(String assetPath) {
    return SizedBox(
      width: size,
      height: size,
      child: FittedBox(
        child: SvgPicture.asset(
          assetPath,
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _StarClipper extends CustomClipper<Rect> {
  _StarClipper(this.fillPercent);

  final double fillPercent;

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width * fillPercent, size.height);
  }

  @override
  bool shouldReclip(_StarClipper oldClipper) {
    return oldClipper.fillPercent != fillPercent;
  }
}
