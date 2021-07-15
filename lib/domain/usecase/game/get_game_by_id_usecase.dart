import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/game/game.dart';
import 'package:mafia/repository/game/game_repository.dart';

abstract class GetGameByIdUseCase extends BaseUseCase<int, Game> {
  final GameRepository _repository;

  GetGameByIdUseCase(this._repository);
}

class GetGameByIdUseCaseImpl extends GetGameByIdUseCase {
  GetGameByIdUseCaseImpl(GameRepository repository) : super(repository);

  @override
  Stream<ApiResource<Game>> execute(int request) =>
      _repository.getGame(request);
}
