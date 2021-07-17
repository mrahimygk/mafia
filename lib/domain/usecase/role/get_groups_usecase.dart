import 'package:mafia/data/model/role/group.dart';
import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/repository/role/group_repository.dart';

abstract class GetGroupsUseCase extends BaseUseCase<void, List<Group>> {}

class GetGroupsUseCaseImpl extends GetGroupsUseCase {
  final GroupRepository _repository;

  GetGroupsUseCaseImpl(this._repository);

  @override
  Stream<ApiResource<List<Group>>> execute(void request) =>
      _repository.getGroups();
}
