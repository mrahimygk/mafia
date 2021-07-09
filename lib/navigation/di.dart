import 'package:mafia/app/di.dart';
import 'package:mafia/navigation/manager.dart';
import 'package:mafia/navigation/routes.dart';

void registerNavigationModule() {
  serviceLocator.registerSingleton<NavigationManager>(
    NavigationManagerImpl(NavigationRoutes.GAME_SETUP),
  );
}
