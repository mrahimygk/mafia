import 'package:mafia/app/di.dart';
import 'package:mafia/domain/usecase/game/get_game_by_id_usecase.dart';
import 'package:mafia/domain/usecase/game/insert_game_usecase.dart';
import 'package:mafia/domain/usecase/game/new_game_usecase.dart';
import 'package:mafia/domain/usecase/occupation/get_occupation_list_usecase.dart';
import 'package:mafia/domain/usecase/occupation/insert_occupation_usecase.dart';
import 'package:mafia/domain/usecase/player/delete_players_by_ids_usecase.dart';
import 'package:mafia/domain/usecase/player/get_players_by_ids_usecase.dart';
import 'package:mafia/domain/usecase/player/get_players_usecase.dart';
import 'package:mafia/domain/usecase/player/insert_player_usecase.dart';
import 'package:mafia/domain/usecase/role/get_group_by_id_usecase.dart';
import 'package:mafia/domain/usecase/role/get_groups_usecase.dart';
import 'package:mafia/domain/usecase/role/get_role_by_id_usecase.dart';
import 'package:mafia/domain/usecase/role/get_roles_usecase.dart';
import 'package:mafia/repository/game/game_repository.dart';
import 'package:mafia/repository/occupation/occupation_repository.dart';
import 'package:mafia/repository/player/player_repository.dart';
import 'package:mafia/repository/role/group_repository.dart';
import 'package:mafia/repository/role/role_repository.dart';

void registerUseCaseModule() {
  serviceLocator.registerFactory<GetGroupsUseCase>(
      () => GetGroupsUseCaseImpl(serviceLocator.get<GroupRepository>()));

  serviceLocator.registerFactory<GetGroupByIdUseCase>(
      () => GetGroupByIdUseCaseImpl(serviceLocator.get<GroupRepository>()));

  serviceLocator.registerFactory<GetRolesUseCase>(
      () => GetRolesUseCaseImpl(serviceLocator.get<RoleRepository>()));

  serviceLocator.registerFactory<GetRoleByIdUseCase>(
      () => GetRoleByIdUseCaseImpl(serviceLocator.get<RoleRepository>()));

  serviceLocator.registerFactory<GetPlayersUseCase>(
      () => GetPlayersUseCaseImpl(serviceLocator.get<PlayerRepository>()));

  serviceLocator.registerFactory<GetPlayersByIdsUseCase>(
      () => GetPlayersByIdsUseCaseImpl(serviceLocator.get<PlayerRepository>()));

  serviceLocator.registerFactory<InsertPlayerUseCase>(
      () => InsertPlayerUseCaseImpl(serviceLocator.get<PlayerRepository>()));

  serviceLocator.registerFactory<DeletePlayersByIdsUseCase>(() =>
      DeletePlayersByIdsUseCaseImpl(serviceLocator.get<PlayerRepository>()));

  serviceLocator.registerFactory<GetOccupationsUseCase>(() =>
      GetOccupationsUseCaseImpl(serviceLocator.get<OccupationRepository>()));

  serviceLocator.registerFactory<GetGameByIdUseCase>(
      () => GetGameByIdUseCaseImpl(serviceLocator.get<GameRepository>()));

  serviceLocator.registerFactory<InsertGameUseCase>(
      () => InsertGameUseCaseImpl(serviceLocator.get<GameRepository>()));

  serviceLocator.registerFactory<InsertOccupationUseCase>(
      () => InsertOccupationUseCaseImpl(
            serviceLocator.get<OccupationRepository>(),
          ));

  serviceLocator.registerFactory<NewGameUseCase>(() => NewGameUseCaseImpl(
        serviceLocator.get<GameRepository>(),
      ));
}
