import '../../config/environment.dart';
import '../core.dart';

Future<void> initApp(Environment env) async {
  setupLocator(env);
  await sl.allReady();

  // await sl<CloudMessagingApi>().initialize();
  // await sl<LocalNotificationsApi>().initialize();
}
