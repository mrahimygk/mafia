import 'package:mafia/app/di.dart';
import 'package:mafia/data/api/coin/coins_api.dart';
import 'package:mafia/data/api/coin/exchange_rate_api.dart';
import 'package:mafia/data/api/posts_api.dart';
import 'package:mafia/data/dio/coinapi_interceptor.dart';
import 'package:mafia/data/dio/dio_interceptor.dart';
import 'package:mafia/data/prefs/app_shared_prefs.dart';
import 'package:mafia/data/prefs/app_shared_prefs_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void registerApiModule() {
  SharedPreferences.getInstance().then(
    (value) => serviceLocator.registerSingleton<AppSharedPreferences>(
      AppSharedPreferencesImpl(value),
    ),
  );

  serviceLocator.registerSingleton(DioInterceptor());
  serviceLocator.registerSingleton(CoinApiInterceptor());

  serviceLocator.registerLazySingleton(() => "https://jsonplaceholder.typicode.com/",
      instanceName: "BASE_URL");

  serviceLocator.registerLazySingleton(() => "https://rest.coinapi.io/v1/",
      instanceName: "BASE_URL_COIN_API");

  serviceLocator.registerSingleton(PostsApi(
      serviceLocator<DioInterceptor>().getDioInstance(),
      baseUrl: serviceLocator.get(instanceName: "BASE_URL")));

  serviceLocator.registerSingleton(CoinsApi(
      serviceLocator<CoinApiInterceptor>().getDioInstance(),
      baseUrl: serviceLocator.get(instanceName: "BASE_URL_COIN_API")));

  serviceLocator.registerSingleton(ExchangeRateApi(
      serviceLocator<CoinApiInterceptor>().getDioInstance(),
      baseUrl: serviceLocator.get(instanceName: "BASE_URL_COIN_API")));
}
