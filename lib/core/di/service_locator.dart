import 'package:get_it/get_it.dart';
import 'package:oonique/modules/main/screens/banners/repositories/repo.dart';
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

  // sp
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

  // notifications
  // sl.registerLazySingleton<CloudMessagingApi>(() => CloudMessagingApi());
  // sl.registerLazySingleton<LocalNotificationsApi>(
  //         () => LocalNotificationsApi());

  // Repositories

  /// ************************************** Authentication **************************************

  // sl.registerLazySingleton<AuthUserRepository>(
  //       () => AuthUserRepository(
  //     storageService: sl<StorageService>(),
  //   ),
  // );
  //
  sl.registerLazySingleton<SessionRepository>(
    () => SessionRepository(
      storageService: sl<StorageService>(),
      authSecuredStorage: sl<AuthSecuredStorage>(),
    ),
  );
  //
  // sl.registerLazySingleton<UserAccountRepository>(
  //   () => UserAccountRepository(
  //       storageService: sl<StorageService>(),
  //       sessionRepository: sl<SessionRepository>(),
  //       dioClient: sl<DioClient>()),
  // );
  //
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(dioClient: sl(), sessionRepository: sl()),
  );

  sl.registerLazySingleton<BannersRepository>(
    () => BannersRepository(dioClient: sl()),
  );
  // // sl.registerLazySingleton<SocketRepository>(() => SocketRepository());
  //
  // sl.registerLazySingleton<ImagePickerRepository>(
  //     () => ImagePickerRepository());
  // sl.registerLazySingleton<ImageCompressRepository>(
  //     () => ImageCompressRepository());
  //
  // sl.registerLazySingleton<ServicesRepository>(() => ServicesRepository());
  // sl.registerLazySingleton<PackagesRepository>(() => PackagesRepository());
  // sl.registerLazySingleton<PartnerRepository>(() => PartnerRepository());
  // sl.registerLazySingleton<CustomerRepository>(() => CustomerRepository());
  // sl.registerLazySingleton<UserDetailRepository>(() => UserDetailRepository());
  // sl.registerLazySingleton<ContactUsRepository>(() => ContactUsRepository());

  /// ************************************** Authentication **************************************

  // sl.registerLazySingleton<AuthUserRepository>(
  //       () => AuthUserRepository(
  //     storageService: sl<StorageService>(),
  //   ),
  // );

  /// ********************************************************************************************
}
