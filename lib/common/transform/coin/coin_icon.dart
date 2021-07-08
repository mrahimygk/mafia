import 'package:mafia/data/model/coin/coin_icon.dart' as data;
import 'package:mafia/domain/model/coin/coin_icon.dart'
    as domain;

extension ToDomain on data.CoinIcon {
  domain.CoinIcon toDomain() => domain.CoinIcon(
        id,
        url,
      );
}
