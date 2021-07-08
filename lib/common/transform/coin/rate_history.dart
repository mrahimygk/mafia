import 'package:mafia/data/model/coin/rate_history.dart' as data;
import 'package:mafia/domain/model/coin/rate_history.dart'
    as domain;

extension ToDomain on data.RateHistory {
  domain.RateHistory toDomain() => domain.RateHistory(
        startingDate,
        endingDate,
        openTime,
        closeTime,
        openRate,
        highRate,
        lowRate,
        closeRate,
      );
}
