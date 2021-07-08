import 'package:mafia/app/di.dart';
import 'package:mafia/domain/usecase/coin/get_history_periods_usecase.dart';
import 'package:mafia/feature/coins/historyperiods/logic/history_periods_cubit.dart';

void registerHistoryPeriodsWidget() {
  serviceLocator.registerFactory<HistoryPeriodsCubit>(() => HistoryPeriodsCubit(
        serviceLocator.get<GetHistoryPeriodsUseCase>(),
      ));
}
