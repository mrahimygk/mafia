import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/repository/player/player_repository.dart';

abstract class InsertPlayerUseCase extends BaseUseCase<String, int> {}

class InsertPlayerUseCaseImpl extends InsertPlayerUseCase {
  final PlayerRepository _repository;

  InsertPlayerUseCaseImpl(this._repository);

  @override
  Stream<ApiResource<int>> execute(String request) =>
      _repository.insertPlayer(request);
}
