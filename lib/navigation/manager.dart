import 'package:flutter/material.dart';
import 'package:mafia/feature/game/cast/view/game_cast_page.dart';
import 'package:mafia/feature/game/setup/view/game_setup_page.dart';
import 'package:mafia/feature/group/view/group_list_page.dart';
import 'package:mafia/feature/lists/view/all_list_page.dart';
import 'package:mafia/feature/player/list/view/player_list_page.dart';
import 'package:mafia/feature/role/details/view/role_details_page.dart';
import 'package:mafia/feature/role/list/view/role_list_page.dart';
import 'package:mafia/navigation/routes.dart';

abstract class NavigationManager {
  final String initialRoute;

  NavigationManager(this.initialRoute);

  Map<String, MaterialPageRoute> initializeNavigationRoutes(
      BuildContext context, RouteSettings settings);

  Future<Object?> pushNamed(
    BuildContext context,
    String destination,
    dynamic args, {
    String? popUntilName,
  });

  void pop(BuildContext context);

  void pushReplacementNamed(
    BuildContext context,
    String destination,
    dynamic args,
  );

  void popAndPushNamed(
    BuildContext context,
    String destination,
    dynamic args,
  );
}

class NavigationManagerImpl extends NavigationManager {
  NavigationManagerImpl(String initialRoute) : super(initialRoute);

  @override
  Map<String, MaterialPageRoute> initializeNavigationRoutes(
          BuildContext context, RouteSettings settings) =>
      {
        NavigationRoutes.PLAYER_LIST: MaterialPageRoute<dynamic>(
          builder: (context) {
            return PlayerListPage();
          },
          settings: settings,
        ),
        NavigationRoutes.GAME_SETUP: MaterialPageRoute<dynamic>(
          builder: (context) {
            return GameSetupPage();
          },
          settings: settings,
        ),
        NavigationRoutes.ROLE_LIST: MaterialPageRoute<dynamic>(
          builder: (context) {
            return RoleListPage();
          },
          settings: settings,
        ),
        NavigationRoutes.ROLE_DETAILS: MaterialPageRoute<dynamic>(
          builder: (context) {
            return RoleDetailsPage();
          },
          settings: settings,
        ),
        NavigationRoutes.GROUP_LIST: MaterialPageRoute<dynamic>(
          builder: (context) {
            return GroupListPage();
          },
          settings: settings,
        ),
        NavigationRoutes.GAME_CAST: MaterialPageRoute<dynamic>(
          builder: (context) {
            return GameCastPage();
          },
          settings: settings,
        ),
        NavigationRoutes.LISTS: MaterialPageRoute<dynamic>(
          builder: (context) {
            return AllListPage();
          },
          settings: settings,
        ),
      };

  @override
  void pop(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  void popAndPushNamed(BuildContext context, String destination, args) {
    Navigator.of(context).popAndPushNamed(destination, arguments: args);
  }

  @override
  void pushReplacementNamed(BuildContext context, String destination, args) {
    Navigator.of(context).pushReplacementNamed(destination, arguments: args);
  }

  @override
  Future<Object?> pushNamed(BuildContext context, String destination, args,
      {String? popUntilName}) {
    if (popUntilName?.trim().isNotEmpty ?? false) {
      return Navigator.pushNamedAndRemoveUntil(
        context,
        destination,
        ModalRoute.withName(destination),
        arguments: args,
      );
    } else {
      return Navigator.pushNamed(context, destination, arguments: args);
    }
  }
}
