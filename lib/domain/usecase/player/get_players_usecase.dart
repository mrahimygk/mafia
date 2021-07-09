import 'package:mafia/data/model/player/player.dart';
import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/repository/player/player_repository.dart';

abstract class GetPlayersUseCase extends BaseUseCase<void, List<Player>> {
  final PlayerRepository _repository;

  GetPlayersUseCase(this._repository);
}

class GetPlayersUseCaseImpl extends GetPlayersUseCase {
  GetPlayersUseCaseImpl(PlayerRepository repository) : super(repository);

  @override
  Stream<ApiResource<List<Player>>> execute(void request) =>
      _repository.getPlayers();
}
