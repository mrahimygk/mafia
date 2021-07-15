import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia/app/di.dart';
import 'package:mafia/common/base/base_page.dart';
import 'package:mafia/common/widgets/api_error_widget.dart';
import 'package:mafia/common/widgets/empty_list_widget.dart';
import 'package:mafia/common/widgets/selectable_item_widget.dart';
import 'package:mafia/domain/model/player/player.dart';
import 'package:mafia/feature/player/insert/view/player_insert_dialog.dart';
import '../logic/player_list_cubit.dart';

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
              showInsertPlayersDialog(context);
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
          return _buildPlayerListView(
              state.players, direction, isDarkMode, context, false);
        }

        if (state is PlayerListDataRemovedState) {
          return _buildPlayerListView(
              state.players, direction, isDarkMode, context, true);
        }

        //throw Exception("Please handle all states above $state");
        return Container();
      },
    );
  }

  @override
  PlayerListCubit getPageBloc() => _cubit;

  Widget _buildPlayerListView(List<Player> players, TextDirection direction,
      bool isDarkMode, BuildContext context, bool isInPhobiaState) {
    return SingleChildScrollView(
      child: Wrap(
        children: _buildPlayerChildren(
            players, direction, isDarkMode, context, isInPhobiaState),
      ),
    );
  }

  List<Widget> _buildPlayerChildren(List<Player> items, TextDirection direction,
      bool isDarkMode, BuildContext context, bool isInPhobiaState) {
    final List<Widget> list = [];
    final List<GlobalKey<SelectableItemWidgetState>> keys = [];
    items.forEach((item) {
      final key = GlobalKey<SelectableItemWidgetState>();
      keys.add(key);
      list.add(SelectableItemWidget(
        item: item,
        key: key,
        onLongPress: () {
          keys.forEach((key) {
            if (key.currentState != null) {
              key.currentState!.togglePhobiaState();
            }
          });
        },
        onRemovePhobiaState: () {
          removePhobiaStates(keys);
        },
        onDeleteItemClick: () {
          _cubit.removePlayer(item);
        },
        isInPhobiaState: isInPhobiaState,
      ));
    });

    list.add(Padding(
      padding: const EdgeInsets.all(4.0),
      child: IconButton(
          icon: Icon(Icons.add_circle_rounded),
          onPressed: () async {
            removePhobiaStates(keys);
            final insertedIds = await showInsertPlayersDialog(context);
            if (insertedIds == null) {
            } else if (insertedIds is Set<int>) {
              _cubit.checkForNewPlayers(insertedIds);
            }
          }),
    ));

    if (list.length < 2) {
      _cubit.getPlayerList();
    }
    return list;
  }

  Future<dynamic> showInsertPlayersDialog(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return PlayerInsertDialog();
        },
      );

  void removePhobiaStates(List<GlobalKey<SelectableItemWidgetState>> keys) {
    keys.forEach((key) {
      if (key.currentState != null) {
        key.currentState!.removePhobiaState();
      }
    });
  }

  List<Player>? getSelectedPlayers() => _cubit.getSelectedPlayers();
}
