import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/game/game.dart';
import 'package:mafia/repository/game/game_repository.dart';

abstract class InsertGameUseCase extends BaseUseCase<Game, int> {}

class InsertGameUseCaseImpl extends InsertGameUseCase {
  final GameRepository _repository;

  InsertGameUseCaseImpl(this._repository);

  @override
  Stream<ApiResource<int>> execute(Game request) =>
      _repository.insertGame(request);
}
