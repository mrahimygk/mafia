import 'package:mafia/data/model/role/role.dart' as data;
import 'package:mafia/domain/model/role/group.dart';
import 'package:mafia/domain/model/role/role.dart' as domain;

extension ToDomain on data.Role {
  domain.Role toDomain(Group group) => domain.Role(
        id,
        name,
        description,
        group,
        false,
        createdDate,
        modifiedDate,
      );
}
