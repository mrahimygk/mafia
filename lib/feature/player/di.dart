import 'package:mafia/app/di.dart';
import 'package:mafia/domain/usecase/player/get_players_by_ids_usecase.dart';
import 'package:mafia/domain/usecase/player/get_players_usecase.dart';

import 'logic/player_list_cubit.dart';

void registerPlayerListPage() {
  serviceLocator.registerFactory<PlayerListCubit>(() => PlayerListCubit(
        serviceLocator.get<GetPlayersUseCase>(),
        serviceLocator.get<GetPlayersByIdsUseCase>(),
      ));
}
