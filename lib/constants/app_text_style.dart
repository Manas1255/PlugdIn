import 'package:flutter/cupertino.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/asset_paths.dart';

extension AppTextStyle on BuildContext {
  String get _bodyFontFamily => AssetPaths.montserrat;
  String get _headingFontFamily => AssetPaths.helveticaNeue;

  // Headlines
  TextStyle get h1 => TextStyle(
    fontFamily: _headingFontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700, // Bold
    color: AppColors.black,
  );

  TextStyle get h2 => TextStyle(
    fontFamily: _headingFontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600, // Semibold
    color: AppColors.black,
  );

  TextStyle get h3 => TextStyle(
    fontFamily: _headingFontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  // Titles
  TextStyle get t1 => TextStyle(
    fontFamily: _bodyFontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  TextStyle get t2 => TextStyle(
    fontFamily: _bodyFontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500, // Medium
    color: AppColors.black,
  );

  TextStyle get t3 => TextStyle(
    fontFamily: _bodyFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  // Body
  TextStyle get b1 => TextStyle(
    fontFamily: _bodyFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700, // Regular
    color: AppColors.black,
  );

  TextStyle get b2 => TextStyle(
    fontFamily: _bodyFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  TextStyle get b3 => TextStyle(
    fontFamily: _bodyFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  // Labels
  TextStyle get l1 => TextStyle(
    fontFamily: _bodyFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  TextStyle get l2 => TextStyle(
    fontFamily: _bodyFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  TextStyle get l3 => TextStyle(
    fontFamily: _bodyFontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  // Specials
  TextStyle get thickText => TextStyle(
    fontFamily: _bodyFontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w900, // Black
    color: AppColors.black,
  );

  TextStyle get lightText => TextStyle(
    fontFamily: _bodyFontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w300, // Light
    color: AppColors.black,
  );

  TextStyle get extraLightText => TextStyle(
    fontFamily: _bodyFontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w200,
    // You don't have UltraLight, fallback to Light
    color: AppColors.black,
  );

  TextStyle get italicBody => TextStyle(
    fontFamily: _bodyFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    // Will apply italic even if no specific italic font
    color: AppColors.black,
  );
}
