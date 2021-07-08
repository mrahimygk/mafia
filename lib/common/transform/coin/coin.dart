import 'package:mafia/data/model/coin/coin.dart' as data;
import 'package:mafia/domain/model/coin/coin.dart' as domain;

extension ToDomain on data.Coin {
  domain.Coin toDomain() => domain.Coin(
        id,
        symbolsCount,
        name,
        website,
        hourlyVolume,
        dailyVolume,
        monthlyVolume,
        null,
      );
}
