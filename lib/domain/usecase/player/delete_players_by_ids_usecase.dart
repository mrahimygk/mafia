import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/repository/player/player_repository.dart';

abstract class DeletePlayersByIdsUseCase
    extends BaseUseCase<List<int>, List<int>> {}

class DeletePlayersByIdsUseCaseImpl extends DeletePlayersByIdsUseCase {
  final PlayerRepository _repository;

  DeletePlayersByIdsUseCaseImpl(this._repository);

  @override
  Stream<ApiResource<List<int>>> execute(List<int> request) =>
      _repository.deletePlayers(request);
}
