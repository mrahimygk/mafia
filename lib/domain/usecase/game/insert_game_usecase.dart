import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/game/game.dart';
import 'package:mafia/repository/game/game_repository.dart';

abstract class InsertGameUseCase extends BaseUseCase<Game, int> {
  final GameRepository _repository;

  InsertGameUseCase(this._repository);
}

class InsertGameUseCaseImpl extends InsertGameUseCase {
  InsertGameUseCaseImpl(GameRepository repository) : super(repository);

  @override
  Stream<ApiResource<int>> execute(Game request) =>
      _repository.insertGame(request);
}
