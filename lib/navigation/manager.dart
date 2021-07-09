import 'package:flutter/material.dart';
import 'package:mafia/feature/player/view/player_list_page.dart';
import 'package:mafia/feature/role/view/role_list_page.dart';
import 'package:mafia/navigation/routes.dart';

abstract class NavigationManager {
  final String initialRoute;

  NavigationManager(this.initialRoute);

  Map<String, WidgetBuilder> initializeNavigationRoutes(
    BuildContext context, {
    required VoidCallback onToggleTheme,
    required Function(int type) onDrawerItemClick,
  });

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
  Map<String, WidgetBuilder> initializeNavigationRoutes(
    BuildContext context, {
    required VoidCallback onToggleTheme,
    required Function(int type) onDrawerItemClick,
  }) =>
      {
        NavigationRoutes.PLAYER_LIST: (context) =>
            PlayerListPage(onToggleTheme, onDrawerItemClick),
        NavigationRoutes.ROLE_LIST: (context) => RoleListPage(onToggleTheme, onDrawerItemClick),
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
