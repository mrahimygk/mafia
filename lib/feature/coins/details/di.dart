import 'package:mafia/app/di.dart';
import 'package:mafia/domain/usecase/coin/get_coin_by_id_usecase.dart';

import 'logic/coin_details_cubit.dart';

void registerCoinDetailsPage() {
  serviceLocator.registerFactory<CoinDetailsCubit>(() => CoinDetailsCubit(
        serviceLocator.get<GetCoinByIdUseCase>(),
      ));
}
