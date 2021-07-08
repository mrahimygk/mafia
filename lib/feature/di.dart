import 'package:mafia/feature/coins/chart/di.dart';
import 'package:mafia/feature/coins/historyperiods/di.dart';
import 'package:mafia/feature/coins/rates/di.dart';
import 'package:mafia/feature/coins/list/di.dart';
import 'package:mafia/feature/posts/di.dart';

import 'coins/details/di.dart';

void registerPageModules(){
  registerPostListPage();
  registerCoinListPage();
  registerCoinDetailsPage();
  registerExchangeRatesPage();
  registerHistoryPeriodsWidget();
  registerCoinChartPage();
}