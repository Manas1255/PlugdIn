import 'package:flutter/cupertino.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/asset_paths.dart';

extension AppTextStyle on BuildContext {
  String get _bodyFontFamily => AssetPaths.montserrat;
  String get _headingFontFamily => AssetPaths.helveticaNeue;

  // --- Helpers --------------------------------------------------------------
  TextStyle _body(double size, FontWeight weight, Color color) => TextStyle(
    fontFamily: _bodyFontFamily,
    fontSize: size,
    fontWeight: weight,
    color: color,
  );

  TextStyle _heading(double size, FontWeight weight, Color color) => TextStyle(
    fontFamily: _headingFontFamily,
    fontSize: size,
    fontWeight: weight,
    color: color,
  );

  TextStyle get h1 => _heading(32, FontWeight.w700, AppColors.black);
  TextStyle get h2 => _heading(28, FontWeight.w600, AppColors.black);
  TextStyle get h3 => _heading(24, FontWeight.w700, AppColors.black);

  TextStyle get t1 => _body(20, FontWeight.w600, AppColors.black);
  TextStyle get t2 => _body(18, FontWeight.w500, AppColors.black);
  TextStyle get t3 => _body(16, FontWeight.w500, AppColors.black);

  TextStyle get t1White => _body(20, FontWeight.w600, AppColors.white);
  TextStyle get t2White => _body(18, FontWeight.w500, AppColors.white);
  TextStyle get t3White => _body(16, FontWeight.w500, AppColors.white);

  TextStyle get b1 => _body(16, FontWeight.w700, AppColors.black);
  TextStyle get b2 => _body(14, FontWeight.w500, AppColors.black);
  TextStyle get b3 => _body(12, FontWeight.w500, AppColors.black);

  TextStyle get b1White => _body(16, FontWeight.w700, AppColors.white);
  TextStyle get b2White => _body(14, FontWeight.w500, AppColors.white);
  TextStyle get b3White => _body(12, FontWeight.w500, AppColors.white);

  TextStyle get l1 => _body(14, FontWeight.w600, AppColors.black);
  TextStyle get l2 => _body(12, FontWeight.w400, AppColors.black);
  TextStyle get l3 => _body(10, FontWeight.w400, AppColors.black);

  TextStyle get l1White => _body(14, FontWeight.w600, AppColors.white);
  TextStyle get l2White => _body(12, FontWeight.w400, AppColors.white);
  TextStyle get l3White => _body(10, FontWeight.w400, AppColors.white);

  TextStyle get thickText => _body(18, FontWeight.w900, AppColors.black);
  TextStyle get lightText => _body(18, FontWeight.w300, AppColors.black);
  TextStyle get extraLightText => _body(18, FontWeight.w200, AppColors.black);

  TextStyle get thickTextWhite => _body(18, FontWeight.w900, AppColors.white);
  TextStyle get lightTextWhite => _body(18, FontWeight.w300, AppColors.white);
  TextStyle get extraLightTextWhite =>
      _body(18, FontWeight.w200, AppColors.white);
}
