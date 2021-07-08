import 'package:mafia/data/model/coin/history_period.dart'
    as data;
import 'package:mafia/domain/model/coin/history_period.dart'
    as domain;

extension ToDomain on data.HistoryPeriod {
  domain.HistoryPeriod toDomain() => domain.HistoryPeriod(
        periodId,
        lengthBySeconds,
        lengthByMonths,
        unitCount,
        unitName,
        displayName,
      );
}
