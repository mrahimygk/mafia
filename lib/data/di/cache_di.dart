import 'package:mafia/app/di.dart';
import 'package:mafia/data/cache/coin/coins_cache.dart';
import 'package:mafia/data/cache/coin/exchange_rate_cache.dart';

void registerCacheModule() {
  serviceLocator.registerSingleton<CoinsCache>(CoinsCacheImpl());
  serviceLocator.registerSingleton<ExchangeRateCache>(ExchangeRateCacheImpl());
}
