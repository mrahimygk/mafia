import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia/app/di.dart';
import 'package:mafia/common/base/base_page.dart';
import 'package:mafia/common/widgets/api_error_widget.dart';
import 'package:mafia/common/widgets/drawer.dart';
import 'package:mafia/common/widgets/empty_list_widget.dart';
import 'package:mafia/feature/player/view/player_list_widget.dart';
import 'package:mafia/feature/role/view/role_list_widget.dart';
import 'package:mafia/feature/setup/logic/game_setup_cubit.dart';
import 'package:mafia/navigation/routes.dart';

class GameSetupPage extends BasePage<GameSetupCubit, GameSetupState, void> {
  final GameSetupCubit _cubit = serviceLocator.get<GameSetupCubit>();

  final VoidCallback onToggleTheme;
  final Function(int type) onDrawerItemClick;

  GameSetupPage(this.onToggleTheme, this.onDrawerItemClick, {Key? key})
      : super(key: key);

  @override
  Widget buildWidget(
    BuildContext context,
    TextDirection direction,
    bool isDarkMode,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text("gameSetup".tr()),
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
        builder: (BuildContext context, GameSetupState state) {
          if (state is GameSetupInitialState) {
            return _buildGameSetupView(direction, isDarkMode, context);
          }

          if (state is GameSetupLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is GameSetupNoDataState) {
            return Center(
              child: EmptyListWidget("addGameSetups", () {
                //TODO: add players dialog
              }),
            );
          }

          if (state is GameSetupErrorState) {
            return Center(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ApiErrorWidget(state.error, () {})),
            );
          }

          throw Exception("Please handle all states above $state");
        },
      ),
    );
  }

  @override
  GameSetupCubit getPageBloc() => _cubit;

  Widget _buildGameSetupView(
      TextDirection direction, bool isDarkMode, BuildContext context) {
    final roleListWidget = RoleListWidget(onToggleTheme, onDrawerItemClick);
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          height: height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text("players".tr()),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, NavigationRoutes.PLAYER_LIST);
                  },
                ),
                Container(
                    height: height / 4,
                    child: PlayerListWidget(onToggleTheme, onDrawerItemClick)),
                ListTile(
                  title: Text("roles".tr()),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, NavigationRoutes.ROLE_LIST);
                  },
                ),
                Container(
                  height: height / 2.5,
                  child: roleListWidget,
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            child: Text("toss".tr()),
            onPressed: () {
              roleListWidget.getSelectedRoles()?.forEach((element) {
                print(element.name);
              });
            },
          ),
        )
      ],
    );
  }
}
