
import 'package:get_it/get_it.dart';

import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // final sharedPrefs = await SharedPreferences.getInstance();

  // shared prefs instance
  // instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  // instance
  //     .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  // instance.registerLazySingleton<NetworkInfo>(
  //         () => NetworkInfoImpl(Connectivity()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  // app  service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

}
