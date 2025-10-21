import 'package:plugdin/app/app.dart';
import 'package:plugdin/bootstrap.dart';
import 'package:plugdin/config/flavor_config.dart';

void main() {
  FlavorConfig(flavor: Flavor.production);
  bootstrap(() => const AppView());
}
