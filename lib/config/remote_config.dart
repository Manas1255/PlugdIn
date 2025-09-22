import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class RemoteConfigService {
  RemoteConfigService({
    FirebaseRemoteConfig? remoteConfig,
  }) : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  final FirebaseRemoteConfig _remoteConfig;

  Future<void> setup({
    RemoteConfigSettings? remoteConfigSettings,
  }) async {
    await _remoteConfig.setConfigSettings(
      remoteConfigSettings ??
          RemoteConfigSettings(
            fetchTimeout: const Duration(minutes: 1),
            minimumFetchInterval: const Duration(minutes: 1),
          ),
    );
    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      debugPrint('remoteConfig.fetchAndActivate error: $e');
    }
  }

  /// Fetch environment-specific values from Remote Config
  String _getString(String key) {
    return _remoteConfig.getString(key);
  }

  String get streamApiKey => _remoteConfig.getString('stream_api_key');
}
