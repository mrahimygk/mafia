import 'package:mafia/app/di.dart';
import 'package:mafia/domain/usecase/game/get_game_by_id_usecase.dart';
import 'package:mafia/domain/usecase/game/new_game_usecase.dart';

import 'logic/game_cast_cubit.dart';

void registerGameCastPage() {
  serviceLocator.registerFactory<GameCastCubit>(() => GameCastCubit(
        serviceLocator.get<GetGameByIdUseCase>(),
        serviceLocator.get<NewGameUseCase>(),
      ));
}
