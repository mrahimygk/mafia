import 'group/di.dart';
import 'lists/di.dart';
import 'player/insert/di.dart';
import 'player/list/di.dart';
import 'role/details/di.dart';
import 'role/list/di.dart';
import 'game/setup/di.dart';

void registerPageModules() {
  registerPlayerListPage();
  registerRoleListPage();
  registerRoleDetailsPage();
  registerGroupListPage();
  registerAllListPage();
  registerGameSetupPage();
  registerPlayerInsertDialogPage();
}
