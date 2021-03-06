import 'package:mafia/common/base/page_cubit.dart';
import 'package:mafia/common/base/page_state.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/base/status.dart';
import 'package:mafia/domain/model/game/game.dart';
import 'package:mafia/domain/model/game/game_insert_request.dart';
import 'package:mafia/domain/usecase/game/get_game_by_id_usecase.dart';
import 'package:mafia/domain/usecase/game/new_game_usecase.dart';

part 'game_cast_state.dart';

class GameCastCubit extends PageCubit<GameCastState> {
  final GetGameByIdUseCase _getGameByIdUseCase;
  final NewGameUseCase _newGameUseCase;

  Game? cachedGame;

  GameCastCubit(
    this._getGameByIdUseCase,
    this._newGameUseCase,
  ) : super(GameCastInitialState());

  void castPlayers(GameInsertRequest request) {
    _newGameUseCase.execute(request).listen((ApiResource<int> event) {
      switch (event.status) {
        case Status.LOADING:
          emit(GameCastLoadingState());
          break;

        case Status.SUCCESS:
          if (event.data == null) {
            emit(GameCastNoDataState());
          } else {
            _getGameByIdUseCase.execute(event.data!).listen((event) {
              switch (event.status) {
                case Status.LOADING:
                  //Handled by the previous call
                  break;

                case Status.SUCCESS:
                  if (event.data == null) {
                    emit(GameCastNoDataState());
                  } else {
                    event.data?.occupations?.shuffle();
                    cachedGame = event.data!;
                    emit(GameCastDataReceivedState(cachedGame!));
                  }
                  break;

                case Status.ERROR:
                  emit(GameCastErrorState(event.message!));
                  break;
              }
            });
          }
          break;

        case Status.ERROR:
          emit(GameCastErrorState(event.message!));
      }
    });
  }
}
