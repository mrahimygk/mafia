
import 'package:mafia/app/di.dart';
import 'package:mafia/feature/setup/logic/game_setup_cubit.dart';

void registerGameSetupPage() {
  serviceLocator.registerFactory<GameSetupCubit>(() => GameSetupCubit());
}
