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

  final Set<int> insertedIds = Set();

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
          if (state is PlayerInsertDataReceivedState) {
            insertedIds.add(state.insertedId);
          }
          return AlertDialog(
            title: state is PlayerInsertInitialState
                ? Text("addPlayer".tr())
                : state is PlayerInsertLoadingState
                    ? Text("addPlayer".tr())
                    : state is PlayerInsertDataReceivedState
                        ? Text("playerHasBeenAdded".tr())
                        : Container(),
            content: state is PlayerInsertInitialState
                ? Column(
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
                      ElevatedButton(
                          onPressed: () {
                            _cubit.insertPlayer(controller.text.toString());
                          },
                          child: Text("add".tr())),
                    ],
                  )
                : state is PlayerInsertLoadingState
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )
                    : state is PlayerInsertDataReceivedState
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("'${controller.text.toString()}'",
                              style: TextStyle(fontSize: 24),),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context, insertedIds);
                                        },
                                        child: Text("close".tr())),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          controller.clear();
                                          _cubit.resetState(
                                              PlayerInsertInitialState());
                                        },
                                        child: Text("addAnotherPlayer".tr())),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Container(),
          );
        });
  }

  @override
  PlayerInsertCubit getPageBloc() => _cubit;
}
