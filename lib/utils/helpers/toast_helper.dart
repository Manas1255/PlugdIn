import 'package:flutter/material.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/utils/widgets/core_widgets/images/svg_pic.dart';
import 'package:toastification/toastification.dart';

class ToastHelper {
  static void showErrorToast(String message) {
    toastification.show(
      backgroundColor: AppColors.red,
      description: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontFamily: AssetPaths.montserrat,
          color: AppColors.offWhite,
          fontSize: 14,
        ),
      ),
      borderRadius: BorderRadius.circular(
        50,
      ),
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 4),
      borderSide: const BorderSide(color: Colors.transparent),
      icon: const PISvgPic(
        AssetPaths.toastError,
        width: 25,
        height: 25,
      ),
      alignment: Alignment.topCenter,
      showProgressBar: false,
      closeButton: const ToastCloseButton(
        showType: CloseButtonShowType.onHover,
      ),
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      progressBarTheme: const ProgressIndicatorThemeData(
        color: Colors.red,
        linearMinHeight: 1,
      ),
    );
  }

  static void showSuccessToast(String message) {
    toastification.show(
      backgroundColor: AppColors.greenSuccess,
      description: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontFamily: AssetPaths.montserrat,
          fontSize: 14,
          color: AppColors.offWhite,
        ),
      ),
      borderRadius: BorderRadius.circular(
        50,
      ),
      borderSide: const BorderSide(color: Colors.transparent),
      type: ToastificationType.success,
      autoCloseDuration: const Duration(seconds: 4),
      showProgressBar: false,
      closeButton: const ToastCloseButton(
        showType: CloseButtonShowType.onHover,
      ),
      icon: const PISvgPic(
        AssetPaths.toastSuccess,
        width: 25,
        height: 25,
      ),
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      progressBarTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryColor,
        linearMinHeight: 1,
      ),
    );
  }

  static void showInfoToast(String message) {
    toastification.show(
      backgroundColor: AppColors.amber,
      description: Text(
        message,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          fontFamily: AssetPaths.montserrat,
          color: AppColors.offWhite,
        ),
      ),
      borderRadius: BorderRadius.circular(
        50,
      ),
      icon: const PISvgPic(
        AssetPaths.toastInfo,
        width: 25,
        height: 25,
      ),
      borderSide: const BorderSide(color: Colors.transparent),
      type: ToastificationType.info,
      autoCloseDuration: const Duration(seconds: 4),
      alignment: Alignment.topCenter,
      showProgressBar: false,
      closeButton: const ToastCloseButton(
        showType: CloseButtonShowType.onHover,
      ),
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      progressBarTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryColor,
        linearMinHeight: 1,
      ),
    );
  }

  static void showCustomToast(String message) {
    toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      title: const Text('Hello, World!'),
      description: RichText(
        text: const TextSpan(text: 'This is a sample toast message. '),
      ),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      icon: const Icon(Icons.check),
      showIcon: true,
      // show or hide the icon
      primaryColor: Colors.green,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
        ),
      ],
      showProgressBar: true,
      closeButton: const ToastCloseButton(
        showType: CloseButtonShowType.onHover,
      ),
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
    );
  }
}
