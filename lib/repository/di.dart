import 'package:mafia/app/di.dart';
import 'package:mafia/data/api/coin/coins_api.dart';
import 'package:mafia/data/api/coin/exchange_rate_api.dart';
import 'package:mafia/data/api/posts_api.dart';
import 'package:mafia/data/cache/coin/coins_cache.dart';
import 'package:mafia/data/cache/coin/exchange_rate_cache.dart';
import 'package:mafia/repository/coins/coins_repository.dart';
import 'package:mafia/repository/coins/exchange_rates_repository.dart';
import 'package:mafia/repository/posts_repository.dart';

void registerRepositoryModule() {
  serviceLocator.registerFactory<PostsRepository>(
      () => PostsRepositoryImpl(serviceLocator.get<PostsApi>()));

  serviceLocator.registerFactory<CoinsRepository>(() => CoinsRepositoryImpl(
      serviceLocator.get<CoinsApi>(), serviceLocator.get<CoinsCache>()));

  serviceLocator.registerFactory<ExchangeRatesRepository>(
      () => ExchangeRatesRepositoryImpl(
            serviceLocator.get<ExchangeRateApi>(),
            serviceLocator.get<ExchangeRateCache>(),
          ));
}
