import 'package:plugdin/config/flavor_config.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class StreamClient {
  StreamClient._();
  static StreamClient? _instance;
  static StreamChatClient? _client;

  static StreamClient get instance {
    _instance ??= StreamClient._();
    return _instance!;
  }

  /// Initialize the Stream client with API key
  Future<void> initialize({required String apiKey}) async {
    try {
      _client = StreamChatClient(
        apiKey,
        logLevel: FlavorConfig.instance.flavor == Flavor.development
            ? Level.INFO
            : Level.SEVERE,
      );
    } catch (e) {
      throw Exception('Failed to initialize Stream client: $e');
    }
  }

  /// Get the Stream client instance
  StreamChatClient get client {
    if (_client == null) {
      throw Exception(
        'Stream client not initialized. Call initialize() first.',
      );
    }
    return _client!;
  }
}
