import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/player/occupation.dart';
import 'package:mafia/repository/occupation/occupation_repository.dart';

abstract class GetOccupationsUseCase
    extends BaseUseCase<void, List<Occupation>> {
  final OccupationRepository _repository;

  GetOccupationsUseCase(this._repository);
}

class GetOccupationsUseCaseImpl extends GetOccupationsUseCase {
  GetOccupationsUseCaseImpl(OccupationRepository repository)
      : super(repository);

  @override
  Stream<ApiResource<List<Occupation>>> execute(void request) =>
      _repository.getOccupations();
}
