import 'package:mafia/data/model/role/group.dart';
import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/repository/role/group_repository.dart';

abstract class GetGroupByIdUseCase extends BaseUseCase<int, Group> {
  final GroupRepository _repository;

  GetGroupByIdUseCase(this._repository);
}

class GetGroupByIdUseCaseImpl extends GetGroupByIdUseCase {
  GetGroupByIdUseCaseImpl(GroupRepository repository) : super(repository);

  @override
  Stream<ApiResource<Group>> execute(int request) =>
      _repository.getGroup(request);
}
