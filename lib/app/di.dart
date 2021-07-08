import 'package:get_it/get_it.dart';
import 'package:mafia/data/db/di.dart';
import 'package:mafia/data/di/cache_di.dart';
import 'package:mafia/navigation/di.dart';

import '../data/di/api_di.dart';
import '../domain/di/usecase_di.dart';
import '../feature/di.dart';
import '../repository/di.dart';

final serviceLocator = GetIt.I;

Future<void> loadDiModules() async {
  registerDbModule();
  registerApiModule();
  registerCacheModule();
  registerRepositoryModule();
  registerUseCaseModule();
  registerNavigationModule();

  registerPageModules();
}
