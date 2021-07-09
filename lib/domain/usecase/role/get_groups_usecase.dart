import 'package:mafia/data/model/role/group.dart';
import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/repository/role/group_repository.dart';

abstract class GetGroupsUseCase extends BaseUseCase<void, List<Group>> {
  final GroupRepository _repository;

  GetGroupsUseCase(this._repository);
}

class GetGroupsUseCaseImpl extends GetGroupsUseCase {
  GetGroupsUseCaseImpl(GroupRepository repository) : super(repository);

  @override
  Stream<ApiResource<List<Group>>> execute(void request) =>
      _repository.getGroups();
}
