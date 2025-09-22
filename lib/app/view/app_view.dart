import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/core/locale/cubit/locale_cubit.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/l10n/gen/app_localizations.dart';
import 'package:toastification/toastification.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Future<bool> _shouldApplySafeArea() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt >= 15;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      );
    });
    return Phoenix(
      child: BlocProvider(
        create: (context) => LocaleCubit(context: context),
        child: BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            return ToastificationWrapper(
              child: MaterialApp.router(
                routerConfig: AppRouter.router,
                theme: ThemeData(
                  scaffoldBackgroundColor: AppColors.primaryColor,
                  textSelectionTheme: const TextSelectionThemeData(
                    cursorColor: AppColors.primaryColor,
                    selectionColor: AppColors.tertiaryColor,
                    selectionHandleColor: AppColors.primaryColor,
                  ),
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  useMaterial3: true,
                ),
                locale: DevicePreview.locale(context),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                debugShowCheckedModeBanner: false,
                builder: (context, child) {
                  return FutureBuilder<bool>(
                    future: _shouldApplySafeArea(),
                    builder: (context, snapshot) {
                      final shouldApplySafeArea = snapshot.data ?? false;
                      if (shouldApplySafeArea) {
                        return SafeArea(
                          maintainBottomViewPadding: true,
                          child: child!,
                        );
                      } else {
                        return child!;
                      }
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
