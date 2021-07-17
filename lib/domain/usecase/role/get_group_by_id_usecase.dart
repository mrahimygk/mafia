import 'package:mafia/data/model/role/group.dart';
import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/repository/role/group_repository.dart';

abstract class GetGroupByIdUseCase extends BaseUseCase<int, Group> {}

class GetGroupByIdUseCaseImpl extends GetGroupByIdUseCase {
  final GroupRepository _repository;

  GetGroupByIdUseCaseImpl(this._repository);

  @override
  Stream<ApiResource<Group>> execute(int request) =>
      _repository.getGroup(request);
}
