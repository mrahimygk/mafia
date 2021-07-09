import 'package:mafia/data/model/role/group.dart' as data;
import 'package:mafia/domain/model/role/group.dart' as domain;

extension ToDomain on data.Group {
  domain.Group toDomain() => domain.Group(
        id,
        name,
        createdDate,
        modifiedDate,
      );
}
