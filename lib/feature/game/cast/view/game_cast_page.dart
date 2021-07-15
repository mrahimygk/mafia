import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:mafia/common/widgets/drawer.dart';
import 'package:mafia/domain/model/game/game_insert_request.dart';
import 'package:mafia/feature/game/cast/view/game_cast_widget.dart';

class GameCastPage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final Function(int type) onDrawerItemClick;

  GameCastPage(this.onToggleTheme, this.onDrawerItemClick, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GameInsertRequest gameInsertRequest =
        ModalRoute.of(context)?.settings.arguments as GameInsertRequest;

    return Scaffold(
      appBar: AppBar(
        title: Text("game".tr()),
      ),
      drawer: AppDrawer(
        onToggleTheme: onToggleTheme,
        onItemClick: onDrawerItemClick,
        onLanguageChanged: (Locale? locale) {
          localization.EasyLocalization.of(context)!.setLocale(locale!);
        },
      ),
      body: GameCastWidget(
        onToggleTheme,
        onDrawerItemClick,
        gameInsertRequest,
      ),
    );
  }
}
