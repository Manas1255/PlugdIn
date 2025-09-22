import 'package:plugdin/config/flavor_config.dart';
import 'package:plugdin/config/remote_config.dart';
import 'package:plugdin/core/di/injector.dart';

/// API Environments & Configurations
enum ApiEnvironment {
  production(
    baseUrl: 'https://fightping.onrender.com/api',
    apiVersion: 'v1',
    mapboxAPIKey:
        'pk.eyJ1IjoiYWN0aXZzcG9ydHMiLCJhIjoiY21hdXl0Ymk5MDJiMDJscXh4NHIzaXBpNiJ9.Q0Sd2wsSe7ATgAT1_GGTGA',
  ),
  development(
    baseUrl: 'https://fightping.onrender.com/api',
    apiVersion: 'v1',
    mapboxAPIKey:
        'pk.eyJ1IjoiYWN0aXZzcG9ydHMiLCJhIjoiY21hdXl0Ymk5MDJiMDJscXh4NHIzaXBpNiJ9.Q0Sd2wsSe7ATgAT1_GGTGA',
  );

  const ApiEnvironment({
    required this.baseUrl,
    required this.apiVersion,
    required this.mapboxAPIKey,
  });

  final String baseUrl;
  final String apiVersion;
  final String mapboxAPIKey;

  /// Get GetStream API Key from Remote Config
  String get getStreamAPIKey {
    try {
      final remoteConfig = Injector.resolve<RemoteConfigService>();
      final apiKey = remoteConfig.streamApiKey;

      // If remote config returns empty string, use fallback
      if (apiKey.isEmpty) {
        return _getFallbackStreamAPIKey();
      }

      return apiKey;
    } catch (e) {
      // Fallback to development key if remote config is not available
      return _getFallbackStreamAPIKey();
    }
  }

  /// Fallback Stream API Key for development
  String _getFallbackStreamAPIKey() {
    switch (FlavorConfig.instance.flavor) {
      case Flavor.development:
        // Use a Stream API key that allows development tokens
        // You should replace this with your actual Stream API key from your Stream dashboard
        return 'x2pg7c3562qn'; // This should be your actual Stream API key
      case Flavor.production:
        // For production, you should always have this configured in Firebase Remote Config
        return '';
    }
  }

  /// Get API Environment Based on Current Flavor**
  static ApiEnvironment get current {
    switch (FlavorConfig.instance.flavor) {
      case Flavor.production:
        return ApiEnvironment.production;
      case Flavor.development:
        return ApiEnvironment.development;
    }
  }
}
