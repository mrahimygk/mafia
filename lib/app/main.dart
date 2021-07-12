import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mafia/common/data/locales.dart';
import 'package:mafia/common/data/preferences_keys.dart';
import 'package:mafia/common/styles/themes.dart';
import 'package:mafia/common/widgets/drawer.dart';
import 'package:mafia/data/prefs/app_shared_prefs.dart';
import 'package:mafia/navigation/manager.dart';

import './app/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await di.loadDiModules();
  runApp(EasyLocalization(
    supportedLocales: appLocaleList.map((e) => e.locale).toList(),
    path: 'assets/translations',
    fallbackLocale: Locale('en'),
    child: MafiaApp(),
  ));
}

class MafiaApp extends StatefulWidget {
  @override
  _MafiaAppState createState() => _MafiaAppState();
}

class _MafiaAppState extends State<MafiaApp> {
  final NavigationManager _navigationManager =
      di.serviceLocator.get<NavigationManager>();
  var isDarkMode =
      WidgetsBinding.instance?.window.platformBrightness == Brightness.dark;

  @override
  void initState() {
    getPrefs()
        .getBoolean(
            BOOL_PREFS_KEY_IS_THEME_DARK,
            WidgetsBinding.instance?.window.platformBrightness ==
                Brightness.dark)
        .then((bool value) {
      setState(() {
        isDarkMode = value;
      });
    });

    WidgetsBinding.instance?.window.onPlatformBrightnessChanged = () {
      final value =
          WidgetsBinding.instance?.window.platformBrightness == Brightness.dark;
      saveThemePrefs(value);
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Mafia',
      initialRoute: _navigationManager.initialRoute,
      routes: _navigationManager.initializeNavigationRoutes(context,
          onToggleTheme: () {
        saveThemePrefs(!isDarkMode);
      }, onDrawerItemClick: (type) {
        switch (type) {
          case AppDrawerItems.LOGIN:
            break;
          case AppDrawerItems.LISTS:
            break;
        }
      }),
      theme: isDarkMode ? darkTheme : lightTheme,
    );
  }

  AppSharedPreferences getPrefs() =>
      di.serviceLocator.get<AppSharedPreferences>();

  void saveThemePrefs(bool newValue) {
    getPrefs()
        .saveBoolean(BOOL_PREFS_KEY_IS_THEME_DARK, newValue)
        .then((bool value) {
      setState(() {
        isDarkMode = newValue;
      });
    });
  }
}
