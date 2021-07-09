import 'package:mafia/data/model/role/role.dart';
import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/repository/role/role_repository.dart';

abstract class GetRolesUseCase extends BaseUseCase<void, List<Role>> {
  final RoleRepository _repository;

  GetRolesUseCase(this._repository);
}

class GetRolesUseCaseImpl extends GetRolesUseCase {
  GetRolesUseCaseImpl(RoleRepository repository) : super(repository);

  @override
  Stream<ApiResource<List<Role>>> execute(void request) =>
      _repository.getRoles();
}
