import 'package:get_it/get_it.dart';
import 'package:oonique/modules/main_module/screens/banners/repositories/repo.dart';
import 'package:oonique/modules/dashboard/view/support/repository/support_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/environment.dart';
import '../../modules/authentication/repositories/auth_repository.dart';
import '../../modules/authentication/repositories/session_repository.dart';
import '../network/dio_client.dart';
import '../security/secured_auth_storage.dart';
import '../storage_service/storage_service.dart';

final sl = GetIt.instance;

void setupLocator(Environment environment) async {
  sl.registerLazySingleton<Environment>(() => environment);

  sl.registerSingletonAsync<SharedPreferences>(
    () async => SharedPreferences.getInstance(),
  );

  // modules
  sl.registerSingletonWithDependencies<StorageService>(
    () => StorageService(sharedPreferences: sl()),
    dependsOn: [SharedPreferences],
  );

  sl.registerLazySingleton<AuthSecuredStorage>(() => AuthSecuredStorage());
  sl.registerLazySingleton<DioClient>(() => DioClient(environment: sl()));

  sl.registerLazySingleton<SessionRepository>(
    () => SessionRepository(
      storageService: sl<StorageService>(),
      authSecuredStorage: sl<AuthSecuredStorage>(),
    ),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(dioClient: sl(), sessionRepository: sl()),
  );

  sl.registerLazySingleton<BannersRepository>(
    () => BannersRepository(dioClient: sl()),
  );

  sl.registerLazySingleton<SupportRepository>(
    () => SupportRepository(dioClient: sl()),
  );
}
