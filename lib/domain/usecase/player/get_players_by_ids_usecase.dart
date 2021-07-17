import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/player/player.dart';
import 'package:mafia/repository/player/player_repository.dart';

abstract class GetPlayersByIdsUseCase
    extends BaseUseCase<List<int>, List<Player>> {}

class GetPlayersByIdsUseCaseImpl extends GetPlayersByIdsUseCase {
  final PlayerRepository _repository;

  GetPlayersByIdsUseCaseImpl(this._repository);

  @override
  Stream<ApiResource<List<Player>>> execute(List<int> request) =>
      _repository.getPlayersByIds(request);
}
