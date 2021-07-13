import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:mafia/common/widgets/drawer.dart';
import './player_list_widget.dart';

class PlayerListPage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final Function(int type) onDrawerItemClick;

  PlayerListPage(this.onToggleTheme, this.onDrawerItemClick, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("playerList".tr()),
        ),
        drawer: AppDrawer(
          onToggleTheme: onToggleTheme,
          onItemClick: onDrawerItemClick,
          onLanguageChanged: (Locale? locale) {
            localization.EasyLocalization.of(context)!.setLocale(locale!);
          },
        ),
        body: PlayerListWidget(onToggleTheme, onDrawerItemClick));
  }
}
