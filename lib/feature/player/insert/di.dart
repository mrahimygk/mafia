
import 'package:mafia/app/di.dart';
import 'package:mafia/domain/usecase/player/insert_player_usecase.dart';
import 'package:mafia/feature/player/insert/logic/player_insert_cubit.dart';

registerPlayerInsertDialogPage(){
  serviceLocator.registerFactory<PlayerInsertCubit>(() => PlayerInsertCubit(serviceLocator.get<InsertPlayerUseCase>()));
}