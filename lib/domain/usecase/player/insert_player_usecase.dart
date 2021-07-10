import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/repository/player/player_repository.dart';

abstract class InsertPlayerUseCase extends BaseUseCase<String, int> {
  final PlayerRepository _repository;

  InsertPlayerUseCase(this._repository);
}

class InsertPlayerUseCaseImpl extends InsertPlayerUseCase {
  InsertPlayerUseCaseImpl(PlayerRepository repository) : super(repository);

  @override
  Stream<ApiResource<int>> execute(String request) =>
      _repository.insertPlayer(request);
}
