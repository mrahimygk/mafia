import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:mafia/app/di.dart' as di;
import 'package:mafia/common/widgets/drawer.dart';
import 'package:mafia/navigation/manager.dart';

@immutable
class MainScaffold extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final Function(int type) onDrawerItemClick;

  static _MainScaffoldState of(BuildContext context) {
    return context.findAncestorStateOfType<_MainScaffoldState>()!;
  }

  const MainScaffold({
    Key? key,
    required this.route,
    required this.onToggleTheme,
    required this.onDrawerItemClick,
  }) : super(key: key);

  final String route;

  @override
  State<StatefulWidget> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  void pushNamed(String route, {Object? arguments}) {
    _navigatorKey.currentState!.pushNamed(route, arguments: arguments);
  }

  void pop() {
    _navigatorKey.currentState!.pop();
  }

  @override
  Widget build(BuildContext context) {
    final NavigationManager _navigationManager =
        di.serviceLocator.get<NavigationManager>();

    return WillPopScope(
      onWillPop: () async {
        if(_navigatorKey.currentState!.canPop()){
          pop();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          //TODO: generate title
          title: Text("game".tr()),
        ),
        drawer: AppDrawer(
          onToggleTheme: widget.onToggleTheme,
          onItemClick: widget.onDrawerItemClick,
          onLanguageChanged: (Locale? locale) {
            localization.EasyLocalization.of(context)!.setLocale(locale!);
          },
        ),
        body: Navigator(
            key: _navigatorKey,
            initialRoute: _navigationManager.initialRoute,
            onGenerateRoute: (RouteSettings settings) {
              final Map<String, MaterialPageRoute> routes = _navigationManager
                  .initializeNavigationRoutes(context, settings);
              return routes[settings.name];
            }),
      ),
    );
  }
}
