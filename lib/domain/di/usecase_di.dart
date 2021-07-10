import 'package:mafia/app/di.dart';
import 'package:mafia/domain/usecase/player/get_players_usecase.dart';
import 'package:mafia/domain/usecase/player/insert_player_usecase.dart';
import 'package:mafia/domain/usecase/role/get_group_by_id_usecase.dart';
import 'package:mafia/domain/usecase/role/get_groups_usecase.dart';
import 'package:mafia/domain/usecase/role/get_role_by_id_usecase.dart';
import 'package:mafia/domain/usecase/role/get_roles_usecase.dart';
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

  serviceLocator.registerFactory<InsertPlayerUseCase>(
      () => InsertPlayerUseCaseImpl(serviceLocator.get<PlayerRepository>()));
}
