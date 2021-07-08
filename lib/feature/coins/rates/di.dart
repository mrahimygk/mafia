import 'package:mafia/app/di.dart';
import 'package:mafia/domain/usecase/coin/get_coin_rates_usecase.dart';
import 'package:mafia/feature/coins/rates/logic/coin_exchange_rates_cubit.dart';

void registerExchangeRatesPage() {
  serviceLocator
      .registerFactory<CoinExchangeRatesCubit>(() => CoinExchangeRatesCubit(
            serviceLocator.get<GetCoinRatesUseCase>(),
          ));
}
