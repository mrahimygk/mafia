import 'package:mafia/common/base/page_cubit.dart';
import 'package:mafia/common/base/page_state.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/base/status.dart';
import 'package:mafia/domain/model/player/player.dart';
import 'package:mafia/domain/usecase/player/insert_player_usecase.dart';

part 'player_insert_state.dart';

class PlayerInsertCubit extends PageCubit<PlayerInsertState> {
  final InsertPlayerUseCase _insertPlayerUseCase;

  PlayerInsertCubit(this._insertPlayerUseCase)
      : super(PlayerInsertInitialState());

  void insertPlayer(String name) {
    _insertPlayerUseCase.execute(name).listen((ApiResource<int> event) {
      switch (event.status) {
        case Status.LOADING:
          emit(PlayerInsertLoadingState());
          break;
        case Status.SUCCESS:
          emit(PlayerInsertDataReceivedState(event.data!));
          break;
        case Status.ERROR:
          emit(PlayerInsertInitialState());
          break;
      }
    });
  }
}
