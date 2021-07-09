import 'package:mafia/common/base/page_cubit.dart';
import 'package:mafia/common/base/page_state.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/base/status.dart';
import 'package:mafia/domain/model/player/player.dart';
import 'package:mafia/domain/usecase/player/get_players_usecase.dart';
import 'package:mafia/navigation/type.dart';

part 'player_list_state.dart';

class PlayerListCubit extends PageCubit<PlayerListState> {
  final GetPlayersUseCase _getPlayersUseCase;

  PlayerListCubit(this._getPlayersUseCase) : super(PlayerListInitialState());

  void getPlayerList() {
    _getPlayersUseCase.execute(null).listen((ApiResource<List<Player>> event) {
      switch (event.status) {
        case Status.LOADING:
          emit(PlayerListLoadingState());
          break;

        case Status.SUCCESS:
          if (event.data == null || (event.data?.isEmpty == true)) {
            emit(PlayerListNoDataState());
          } else {
            emit(PlayerListDataReceivedState(event.data!));
          }
          break;

        case Status.ERROR:
          emit(PlayerListErrorState(event.message!));
      }
    }).onError((e, s) {
      emit(PlayerListErrorState(e.toString()));
    });
  }

  void navigateToPlayerDetails(Player player) {
    //emit(PlayerListNavigationState(NavigationRoutes.DETAILS, player));
  }
}
