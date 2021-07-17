import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/player/player.dart';
import 'package:mafia/repository/player/player_repository.dart';

abstract class GetPlayersUseCase extends BaseUseCase<void, List<Player>> {}

class GetPlayersUseCaseImpl extends GetPlayersUseCase {
  final PlayerRepository _repository;

  GetPlayersUseCaseImpl(this._repository);

  @override
  Stream<ApiResource<List<Player>>> execute(void request) =>
      _repository.getPlayers();
}
