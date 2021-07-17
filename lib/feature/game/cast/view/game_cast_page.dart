import 'package:flutter/material.dart';
import 'package:mafia/domain/model/game/game_insert_request.dart';
import 'package:mafia/feature/game/cast/view/game_cast_widget.dart';

class GameCastPage extends StatelessWidget {
  GameCastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GameInsertRequest gameInsertRequest =
        ModalRoute.of(context)?.settings.arguments as GameInsertRequest;

    return GameCastWidget(gameInsertRequest);
  }
}
