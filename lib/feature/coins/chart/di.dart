
import 'package:mafia/app/di.dart';
import 'package:mafia/domain/usecase/coin/get_rate_history_usecase.dart';
import 'package:mafia/feature/coins/chart/logic/coin_chart_cubit.dart';

void registerCoinChartPage(){
  serviceLocator.registerFactory<CoinChartCubit>(() => CoinChartCubit(
    serviceLocator.get<GetRateHistoryUseCase>()
  ));
}