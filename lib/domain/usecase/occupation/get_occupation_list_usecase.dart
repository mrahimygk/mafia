import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/player/occupation.dart';
import 'package:mafia/repository/occupation/occupation_repository.dart';

abstract class GetOccupationsUseCase
    extends BaseUseCase<void, List<Occupation>> {}

class GetOccupationsUseCaseImpl extends GetOccupationsUseCase {
  final OccupationRepository _repository;

  GetOccupationsUseCaseImpl(this._repository);

  @override
  Stream<ApiResource<List<Occupation>>> execute(void request) =>
      _repository.getOccupations();
}
