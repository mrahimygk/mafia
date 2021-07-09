import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia/app/di.dart';
import 'package:mafia/common/base/base_page.dart';
import 'package:mafia/common/widgets/api_error_widget.dart';
import 'package:mafia/common/widgets/drawer.dart';
import 'package:mafia/data/model/player/player.dart';
import 'package:mafia/feature/player/logic/player_list_cubit.dart';

class PlayerListPage extends BasePage<PlayerListCubit, PlayerListState, void> {
  final PlayerListCubit _cubit = serviceLocator.get<PlayerListCubit>();

  final VoidCallback onToggleTheme;
  final Function(int type) onDrawerItemClick;

  PlayerListPage(this.onToggleTheme, this.onDrawerItemClick, {Key? key})
      : super(key: key) {
    _cubit.getPlayerList();
  }

  @override
  Widget buildWidget(
    BuildContext context,
    TextDirection direction,
    bool isDarkMode,
  ) {
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
      body: BlocBuilder(
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
            return Text("No data, add players");
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
      ),
    );
  }

  @override
  PlayerListCubit getPageBloc() => _cubit;

  Widget _buildPlayerListView(
      List<Player> players, TextDirection direction, bool isDarkMode) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.5,
        ),
        itemCount: players.length,
        itemBuilder: (context, index) {
          final item = players[index];
          return GestureDetector(
            onTapUp: (d) {
              // _cubit.navigateToPlayerDetails(item);
            },
            child: Text(
              "${item.name} (${item.id})",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        });
  }
}
