import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plugdin/config/remote_config.dart';
import 'package:plugdin/core/api_service/api_service.dart';
import 'package:plugdin/core/app_preferences/app_preferences.dart';

abstract class AppModule {
  static late final GetIt _container;

  static Future<void> setup(GetIt container) async {
    _container = container;
    await _setupHive();
    await _setupAppPreferences();
    await _setupFirebaseRemoteConfig();
    await _setupAPIService();

    // await _setupAwesomeNotifications();
  }

  static Future<void> _setupHive() async {
    await Hive.initFlutter();
  }

  static Future<void> _setupAPIService() async {
    final apiService = ApiService();
    _container.registerSingleton<ApiService>(apiService);
  }

  static Future<void> _setupAppPreferences() async {
    final appPreferences = AppPreferences();
    await appPreferences.init('app-storage');
    _container.registerSingleton<AppPreferences>(appPreferences);
  }

  static Future<void> _setupFirebaseRemoteConfig() async {
    final instance = RemoteConfigService();
    await instance.setup();
    _container.registerSingleton<RemoteConfigService>(instance);
  }

  // static Future<void> _setupAwesomeNotifications() async {
  //   final awesomeNotificationService = AwesomeNotificationService();
  //   await awesomeNotificationService.initialize();
  //   await awesomeNotificationService.initializeFCM();
  //   _container.registerSingleton<AwesomeNotificationService>(
  //     awesomeNotificationService,
  //   );
  // }
}

class UserModelAdapter {}
