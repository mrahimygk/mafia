import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/game/game_insert_request.dart';
import 'package:mafia/repository/game/game_repository.dart';

abstract class NewGameUseCase extends BaseUseCase<GameInsertRequest, int> {}

class NewGameUseCaseImpl extends NewGameUseCase {
  final GameRepository _repository;

  NewGameUseCaseImpl(this._repository);

  @override
  Stream<ApiResource<int>> execute(GameInsertRequest request) =>
      _repository.newGame(request.players, request.roles);
}
