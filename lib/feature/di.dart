import 'package:mafia/feature/player/list/di.dart';
import 'package:mafia/feature/player/insert/di.dart';
import 'package:mafia/feature/role/list/di.dart';
import 'package:mafia/feature/setup/di.dart';

import 'group/di.dart';
import 'lists/di.dart';

void registerPageModules() {
  registerPlayerListPage();
  registerRoleListPage();
  registerGroupListPage();
  registerAllListPage();
  registerGameSetupPage();
  registerPlayerInsertDialogPage();
}
