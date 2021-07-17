import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/role/role.dart';
import 'package:mafia/repository/role/role_repository.dart';

abstract class GetRolesUseCase extends BaseUseCase<void, List<Role>> {}

class GetRolesUseCaseImpl extends GetRolesUseCase {
  final RoleRepository _repository;

  GetRolesUseCaseImpl(this._repository);

  @override
  Stream<ApiResource<List<Role>>> execute(void request) =>
      _repository.getRoles();
}
