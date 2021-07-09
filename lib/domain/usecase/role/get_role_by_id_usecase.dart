import 'package:mafia/domain/model/role/role.dart';
import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/repository/role/role_repository.dart';

abstract class GetRoleByIdUseCase extends BaseUseCase<int, Role> {
  final RoleRepository _repository;

  GetRoleByIdUseCase(this._repository);
}

class GetRoleByIdUseCaseImpl extends GetRoleByIdUseCase {
  GetRoleByIdUseCaseImpl(RoleRepository repository) : super(repository);

  @override
  Stream<ApiResource<Role>> execute(int request) =>
      _repository.getRole(request);
}
