import 'package:mafia/domain/model/player/player.dart';
import 'package:mafia/domain/model/role/role.dart';

class GameInsertRequest {
  final List<Player> players;
  final List<Role> roles;

  GameInsertRequest(
    this.players,
    this.roles,
  );
}
