import 'package:mafia/data/model/player/player.dart';
import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/repository/player/player_repository.dart';

abstract class GetPlayerByIdUseCase extends BaseUseCase<int, Player> {
  final PlayerRepository _repository;

  GetPlayerByIdUseCase(this._repository);
}

class GetPlayerByIdUseCaseImpl extends GetPlayerByIdUseCase {
  GetPlayerByIdUseCaseImpl(PlayerRepository repository) : super(repository);

  @override
  Stream<ApiResource<Player>> execute(int request) =>
      _repository.getPlayer(request);
}
