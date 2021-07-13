
import 'package:mafia/app/di.dart';
import 'logic/game_setup_cubit.dart';

void registerGameSetupPage() {
  serviceLocator.registerFactory<GameSetupCubit>(() => GameSetupCubit());
}
