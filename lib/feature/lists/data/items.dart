import 'package:mafia/navigation/routes.dart';

class ListItem {
  final int id;
  final String title;
  final String route;

  ListItem(this.id, this.title, this.route);
}

final listItems = [
  ListItem(1, "groups", NavigationRoutes.GROUP_LIST),
  ListItem(2, "players", NavigationRoutes.PLAYER_LIST),
  ListItem(3, "roles", NavigationRoutes.ROLE_LIST),
];
