import 'package:mafia/data/model/role/role.dart' as data;
import 'package:mafia/domain/model/role/role.dart' as domain;

import './group.dart';

extension ToDomain on data.Role {
  domain.Role toDomain() => domain.Role(
        id,
        name,
        description,
        group!.toDomain(),
        false,
        createdDate,
        modifiedDate,
      );
}
