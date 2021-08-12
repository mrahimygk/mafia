import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia/app/di.dart';
import 'package:mafia/common/base/base_page.dart';
import 'package:mafia/common/widgets/api_error_widget.dart';
import 'package:mafia/common/widgets/empty_list_widget.dart';
import 'package:mafia/domain/model/game/game.dart';
import 'package:mafia/domain/model/game/game_insert_request.dart';

import '../logic/game_cast_cubit.dart';

class GameCastWidget extends BasePage<GameCastCubit, GameCastState, void> {
  final GameCastCubit _cubit = serviceLocator.get<GameCastCubit>();

  final GameInsertRequest gameInsertRequest;

  GameCastWidget(this.gameInsertRequest, {Key? key}) : super(key: key) {
    _cubit.castPlayers(gameInsertRequest);
  }

  @override
  Widget buildWidget(
    BuildContext context,
    TextDirection direction,
    bool isDarkMode,
  ) {
    return BlocBuilder(
      bloc: _cubit,
      buildWhen: (previousState, currentState) {
        return previousState != currentState;
      },
      builder: (BuildContext context, GameCastState state) {
        if (state is GameCastInitialState) {
          return Container();
        }

        if (state is GameCastLoadingState) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is GameCastNoDataState) {
          return Center(
            child: EmptyListWidget("gameCasts".tr(), () {
              //TODO: bad
            }),
          );
        }

        if (state is GameCastErrorState) {
          return Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ApiErrorWidget(state.error, () {})),
          );
        }

        if (state is GameCastDataReceivedState) {
          return _buildGameCastView(state.game, direction, isDarkMode, context);
        }

        throw Exception("Please handle all states above $state");
      },
    );
  }

  @override
  GameCastCubit getPageBloc() => _cubit;

  Widget _buildGameCastView(
    Game game,
    TextDirection direction,
    bool isDarkMode,
    BuildContext context,
  ) {
    return ListView.builder(
      itemCount: game.occupations?.length,
      itemBuilder: (BuildContext context, int index) {
        final item = game.occupations![index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: Center(child: Text(item.player.name))),
                Expanded(child: Center(child: Text(item.role.name))),
              ],
            ),
          ),
        );
      },
    );
  }
}
