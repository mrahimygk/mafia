import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/game/game.dart';
import 'package:mafia/repository/game/game_repository.dart';

abstract class GetGameByIdUseCase extends BaseUseCase<int, Game> {}

class GetGameByIdUseCaseImpl extends GetGameByIdUseCase {
  final GameRepository _repository;

  GetGameByIdUseCaseImpl(this._repository);

  @override
  Stream<ApiResource<Game>> execute(int request) =>
      _repository.getGame(request);
}
