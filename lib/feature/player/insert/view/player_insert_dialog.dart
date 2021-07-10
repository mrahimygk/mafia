import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia/app/di.dart';
import 'package:mafia/common/base/base_page.dart';
import 'package:mafia/feature/player/insert/logic/player_insert_cubit.dart';

class PlayerInsertDialog
    extends BasePage<PlayerInsertCubit, PlayerInsertState, void> {
  final _cubit = serviceLocator.get<PlayerInsertCubit>();

  final controller = TextEditingController();

  @override
  Widget buildWidget(
      BuildContext context, TextDirection direction, bool isDarkMode) {
    return BlocBuilder(
        bloc: _cubit,
        buildWhen: (previousState, currentState) {
          return previousState is PlayerInsertState &&
              currentState is PlayerInsertState &&
              previousState != currentState;
        },
        builder: (BuildContext context, PlayerInsertState state) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("addPlayer".tr()),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "playerName".tr(),
                      helperText: "playerName".tr(),
                    ),
                  ),
                  if (state is PlayerInsertInitialState)
                    ElevatedButton(
                        onPressed: () {
                          _cubit.insertPlayer(controller.text.toString());
                        },
                        child: Text("add".tr()))
                  else
                    state is PlayerInsertLoadingState
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("close".tr()))
                ],
              ),
            );
          });
        });
  }

  @override
  PlayerInsertCubit getPageBloc() => _cubit;
}
