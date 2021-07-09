import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mafia/common/data/locales.dart';
import 'package:mafia/domain/model/locale/app_locale.dart';
import 'package:mafia/navigation/routes.dart';

class AppDrawer extends StatefulWidget {
  final Function(Locale? locale)? onLanguageChanged;
  final VoidCallback onToggleTheme;
  final Function(int type) onItemClick;

  const AppDrawer({
    Key? key,
    this.onLanguageChanged,
    required this.onToggleTheme,
    required this.onItemClick,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppDrawerState(
        onToggleTheme: onToggleTheme,
        onLanguageChanged: onLanguageChanged,
        onItemClick: onItemClick,
      );
}

class AppDrawerState extends State<AppDrawer> {
  Locale? currentLocale;
  bool isDarkMode = false;

  final Function(Locale? locale)? onLanguageChanged;
  final VoidCallback onToggleTheme;
  final Function(int type) onItemClick;

  AppDrawerState({
    Key? key,
    this.onLanguageChanged,
    required this.onToggleTheme,
    required this.onItemClick,
  });

  @override
  Widget build(BuildContext context) {
    isDarkMode = Theme.of(context).brightness == Brightness.dark;
    currentLocale = EasyLocalization.of(context)?.currentLocale;
    final items = AppDrawerItems.get();
    return Drawer(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          if (item.type == AppDrawerItems.HEADER) {
            return DrawerHeader(
              child: Container(
                height: 240.0,
                color: Colors.green,
              ),
            );
          }
          if (item.type == AppDrawerItems.LANGUAGE) {
            return ListTile(
              title: Text(items[index].title.tr()),
              trailing: DropdownButton<Locale>(
                value: currentLocale,
                onChanged: (Locale? newValue) {
                  setState(() {
                    currentLocale = newValue;
                    onLanguageChanged?.call(newValue);
                  });
                },
                items: appLocaleList
                    .map<DropdownMenuItem<Locale>>(
                      (AppLocale e) => DropdownMenuItem(
                        child: Text(e.name),
                        value: e.locale,
                      ),
                    )
                    .toList(),
              ),
            );
          }

          if (item.type == AppDrawerItems.DARK_MODE) {
            return ListTile(
                title: Text(items[index].title.tr()),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (bool newValue) {
                    onToggleTheme.call();
                  },
                ));
          }

          return GestureDetector(
              onTapUp: (d) {
                final item = items[index];
                onItemClick(item.type);
                switch (item.type) {
                  case AppDrawerItems.LISTS:
                    Navigator.pushNamed(context, NavigationRoutes.LISTS);
                }
              },
              child: ListTile(
                title: Text(items[index].title.tr()),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                ),
              ));
        },
      ),
    );
  }
}

abstract class IDrawerItem {
  final String title;
  final int type;

  IDrawerItem(this.title, this.type);
}

class SimpleDrawerItem extends IDrawerItem {
  SimpleDrawerItem(String titleKey, int type) : super(titleKey, type);
}

class DrawerItem extends IDrawerItem {
  DrawerItem(String titleKey, int type) : super(titleKey, type);
}

class AppDrawerItems {
  static const int HEADER = 0;
  static const int LOGIN = 1;
  static const int LANGUAGE = 2;
  static const int DARK_MODE = 3;
  static const int LISTS = 4;

  static List<IDrawerItem> get() {
    return [
      DrawerItem("HEADER", HEADER),
      SimpleDrawerItem("login", LOGIN),
      DrawerItem("language", LANGUAGE),
      DrawerItem("darkMode", DARK_MODE),
      DrawerItem("lists", LISTS),
    ];
  }
}
