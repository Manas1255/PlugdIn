import 'package:device_preview/device_preview.dart';
import 'package:plugdin/app/view/app.dart';
import 'package:plugdin/bootstrap.dart';
import 'package:plugdin/config/flavor_config.dart';

Future<void> main() async {
  FlavorConfig(flavor: Flavor.development);
  await bootstrap(
    () => DevicePreview(
      builder: (context) => const App(),
    ),
  );
}
