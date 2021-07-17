import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/player/player.dart';
import 'package:mafia/repository/player/player_repository.dart';

abstract class GetPlayerByIdUseCase extends BaseUseCase<int, Player> {}

class GetPlayerByIdUseCaseImpl extends GetPlayerByIdUseCase {
  final PlayerRepository _repository;

  GetPlayerByIdUseCaseImpl(this._repository);

  @override
  Stream<ApiResource<Player>> execute(int request) =>
      _repository.getPlayer(request);
}
