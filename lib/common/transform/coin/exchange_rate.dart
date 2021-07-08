import 'package:mafia/data/model/coin/exchange_rate.dart'
    as data;
import 'package:mafia/domain/model/coin/exchange_rate.dart'
    as domain;

extension ToDomain on data.ExchangeRate {
  domain.ExchangeRate toDomain() => domain.ExchangeRate(
        time,
        coinId,
        rate,
      );
}
