import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/player/occupation_insert_request.dart';
import 'package:mafia/repository/occupation/occupation_repository.dart';

abstract class InsertOccupationUseCase
    extends BaseUseCase<OccupationInsertRequest, int> {}

class InsertOccupationUseCaseImpl extends InsertOccupationUseCase {
  final OccupationRepository _repository;

  InsertOccupationUseCaseImpl(this._repository);

  @override
  Stream<ApiResource<int>> execute(OccupationInsertRequest request) =>
      _repository.insertOccupation(request);
}
