import 'package:plugdin/config/remote_config.dart';
import 'package:plugdin/core/di/injector.dart';

class Environment {
  static RemoteConfigService get _config =>
      Injector.resolve<RemoteConfigService>();
}
