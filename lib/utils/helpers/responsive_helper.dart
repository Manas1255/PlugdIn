import 'package:flutter/material.dart';

/// A comprehensive helper class for managing responsive design
/// across different screen sizes and device types (mobile and tablet)
class ResponsiveHelper {
  // Private constructor to prevent instantiation
  ResponsiveHelper._();

  // Breakpoint constants
  static const double smallMobileBreakpoint = 380; // iPhone SE and similar small devices
  static const double mobileBreakpoint = 600; // Regular mobile devices

  // Screen size categories with height consideration
  static const double smallMobile = 320; // iPhone SE (1st gen) 320x568
  static const double smallMobileHeight = 680; // iPhone SE height threshold
  static const double mediumMobile = 375; // iPhone 12/13 Mini
  static const double largeMobile = 414; // iPhone 12/13 Pro Max
  static const double smallTablet = 768; // iPad Mini
  static const double largeTablet = 1024; // iPad Pro

  /// Get the screen width
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get the screen height
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Check if device is small mobile (width < 350) - iPhone SE and similar
  static bool isSmallMobile(BuildContext context) {
    return screenWidth(context) < smallMobileBreakpoint;
  }

  /// Check if device is regular mobile (width < 600)
  static bool isMobile(BuildContext context) {
    return screenWidth(context) < mobileBreakpoint;
  }

  /// Check if device is tablet (width >= 600)
  static bool isTablet(BuildContext context) {
    return screenWidth(context) >= mobileBreakpoint;
  }

  /// Check if device is in landscape orientation
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Check if device is in portrait orientation
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// Get device type as enum
  static DeviceType getDeviceType(BuildContext context) {
    if (isSmallMobile(context)) return DeviceType.smallMobile;
    if (isMobile(context)) return DeviceType.mobile;
    return DeviceType.tablet;
  }

  /// Return different values based on device type
  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? smallMobile,
  }) {
    if (isTablet(context)) return tablet ?? mobile;
    if (isSmallMobile(context)) return smallMobile ?? mobile;
    return mobile;
  }

  /// Return different values based on screen width breakpoints
  static T responsiveWidth<T>(
    BuildContext context, {
    required T small,
    T? medium,
    T? large,
  }) {
    final width = screenWidth(context);

    if (width >= mobileBreakpoint) return large ?? medium ?? small;
    if (width >= smallMobileBreakpoint) return medium ?? small;
    return small;
  }

  /// Get responsive font size
  static double fontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? smallMobile,
  }) {
    return responsive<double>(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.1,
      smallMobile: smallMobile ?? mobile * 0.9,
    );
  }

  /// Get responsive padding
  static EdgeInsets padding(
    BuildContext context, {
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? smallMobile,
  }) {
    return responsive<EdgeInsets>(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.2,
      smallMobile: smallMobile ?? mobile * 0.8,
    );
  }

  /// Get responsive margin
  static EdgeInsets margin(
    BuildContext context, {
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? smallMobile,
  }) {
    return responsive<EdgeInsets>(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.2,
      smallMobile: smallMobile ?? mobile * 0.8,
    );
  }

  /// Get responsive spacing
  static double spacing(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? smallMobile,
  }) {
    return responsive<double>(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.2,
      smallMobile: smallMobile ?? mobile * 0.8,
    );
  }

  /// Get responsive width as percentage of screen width
  static double widthPercent(BuildContext context, double percent) {
    return screenWidth(context) * (percent / 100);
  }

  /// Get responsive height as percentage of screen height
  static double heightPercent(BuildContext context, double percent) {
    return screenHeight(context) * (percent / 100);
  }

  /// Get responsive size based on smaller dimension
  static double responsiveSize(BuildContext context, double baseSize) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    final scaleFactor = shortestSide / 375; // Base on iPhone X width
    return baseSize * scaleFactor;
  }

  /// Get grid column count based on screen size
  static int getGridColumnCount(
    BuildContext context, {
    int mobile = 2,
    int tablet = 3,
    int smallMobile = 1,
  }) {
    return responsive<int>(
      context,
      mobile: mobile,
      tablet: tablet,
      smallMobile: smallMobile,
    );
  }

  /// Get app bar height based on device type
  static double getAppBarHeight(BuildContext context) {
    return responsive<double>(
      context,
      mobile: kToolbarHeight,
      tablet: kToolbarHeight + 8,
      smallMobile: kToolbarHeight - 4,
    );
  }

  /// Get responsive border radius
  static double borderRadius(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? smallMobile,
  }) {
    return responsive<double>(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.2,
      smallMobile: smallMobile ?? mobile * 0.8,
    );
  }

  /// Get responsive card elevation
  static double cardElevation(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? smallMobile,
  }) {
    return responsive<double>(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.1,
      smallMobile: smallMobile ?? mobile * 0.9,
    );
  }

  /// Check if device is a large mobile device
  static bool isLargeMobile(BuildContext context) {
    final width = screenWidth(context);
    return width > mediumMobile && width < mobileBreakpoint;
  }

  /// Get safe area padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Get responsive icon size
  static double iconSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? smallMobile,
  }) {
    return responsive<double>(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.15,
      smallMobile: smallMobile ?? mobile * 0.85,
    );
  }

  /// Calculate responsive value using linear interpolation
  static double lerp(
    BuildContext context, {
    required double minValue,
    required double maxValue,
    double minWidth = 320,
    double maxWidth = 768,
  }) {
    final width = screenWidth(context).clamp(minWidth, maxWidth);
    final factor = (width - minWidth) / (maxWidth - minWidth);
    return minValue + (maxValue - minValue) * factor;
  }

  /// Get responsive screen height value for different device sizes
  static double screenHeightValue(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? smallMobile,
  }) {
    return responsive<double>(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 0.9,
      // Tablets are wider, so slightly less height percentage
      smallMobile:
          smallMobile ??
          mobile * 1.1, // Small phones need more height percentage
    );
  }
}

/// Device type enumeration
enum DeviceType { smallMobile, mobile, tablet }

/// Extension to make ResponsiveHelper easier to use
extension ResponsiveExtension on BuildContext {
  /// Check if current device is small mobile
  bool get isSmallMobile => ResponsiveHelper.isSmallMobile(this);

  /// Check if current device is mobile
  bool get isMobile => ResponsiveHelper.isMobile(this);

  /// Check if current device is tablet
  bool get isTablet => ResponsiveHelper.isTablet(this);

  /// Get device type
  DeviceType get deviceType => ResponsiveHelper.getDeviceType(this);

  /// Get screen width
  double get screenWidth => ResponsiveHelper.screenWidth(this);

  /// Get screen height
  double get screenHeight => ResponsiveHelper.screenHeight(this);

  /// Check if device is in landscape
  bool get isLandscape => ResponsiveHelper.isLandscape(this);

  /// Check if device is in portrait
  bool get isPortrait => ResponsiveHelper.isPortrait(this);
}
