import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia/app/di.dart';
import 'package:mafia/common/base/base_page.dart';
import 'package:mafia/common/widgets/api_error_widget.dart';
import 'package:mafia/common/widgets/empty_list_widget.dart';
import 'package:mafia/domain/model/player/player.dart';
import 'package:mafia/feature/player/logic/player_list_cubit.dart';
import 'package:mafia/feature/role/view/role_item_widget.dart';

class PlayerListWidget
    extends BasePage<PlayerListCubit, PlayerListState, void> {
  final PlayerListCubit _cubit = serviceLocator.get<PlayerListCubit>();

  final VoidCallback onToggleTheme;
  final Function(int type) onDrawerItemClick;

  PlayerListWidget(this.onToggleTheme, this.onDrawerItemClick, {Key? key})
      : super(key: key) {
    _cubit.getPlayerList();
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
        builder: (BuildContext context, PlayerListState state) {
          if (state is PlayerListInitialState ||
              state is PlayerListNavigationState) {
            return Container(color: Colors.white);
          }

          if (state is PlayerListLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is PlayerListNoDataState) {
            return Center(
              child: EmptyListWidget("addPlayers", () {
                //TODO: add players dialog
              }),
            );
          }

          if (state is PlayerListErrorState) {
            return Center(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ApiErrorWidget(state.error, () {
                    _cubit.getPlayerList();
                  })),
            );
          }

          if (state is PlayerListDataReceivedState) {
            return _buildPlayerListView(state.players, direction, isDarkMode);
          }

          throw Exception("Please handle all states above $state");
        },
      );
  }

  @override
  PlayerListCubit getPageBloc() => _cubit;

  Widget _buildPlayerListView(
      List<Player> players, TextDirection direction, bool isDarkMode) {
    return SingleChildScrollView(
      child: Wrap(
        children: _buildRoleChildren(players, direction, isDarkMode),
      ),
    );
  }

  List<Widget> _buildRoleChildren(
      List<Player> roles, TextDirection direction, bool isDarkMode) {
    final List<Widget> list = [];
    roles.forEach((item) {
      list.add(RoleItemWidget(item: item));
    });

    return list;
  }
}
