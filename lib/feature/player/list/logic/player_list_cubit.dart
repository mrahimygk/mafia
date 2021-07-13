import 'package:mafia/common/base/page_cubit.dart';
import 'package:mafia/common/base/page_state.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/base/status.dart';
import 'package:mafia/domain/model/player/player.dart';
import 'package:mafia/domain/usecase/player/delete_players_by_ids_usecase.dart';
import 'package:mafia/domain/usecase/player/get_players_by_ids_usecase.dart';
import 'package:mafia/domain/usecase/player/get_players_usecase.dart';
import 'package:mafia/navigation/type.dart';

part 'player_list_state.dart';

class PlayerListCubit extends PageCubit<PlayerListState> {
  final GetPlayersUseCase _getPlayersUseCase;
  final GetPlayersByIdsUseCase _getPlayersByIdsUseCase;
  final DeletePlayersByIdsUseCase _deletePlayersByIdsUseCase;

  List<Player>? cachedPlayers;

  PlayerListCubit(
    this._getPlayersUseCase,
    this._getPlayersByIdsUseCase,
    this._deletePlayersByIdsUseCase,
  ) : super(PlayerListInitialState());

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
            cachedPlayers = event.data!;
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

  void checkForNewPlayers(Set<int> insertedIds) {
    cachedPlayers == null || cachedPlayers!.isEmpty
        ? getPlayerList()
        : _getPlayersByIdsUseCase
            .execute(insertedIds.toList())
            .listen((ApiResource<List<Player>> event) {
            switch (event.status) {
              case Status.LOADING:
                emit(PlayerListLoadingState());
                break;

              case Status.SUCCESS:
                if (event.data == null) {
                  emit(PlayerListDataReceivedState(cachedPlayers!));
                } else {
                  cachedPlayers!.addAll(event.data!);
                  emit(PlayerListDataReceivedState(cachedPlayers!));
                }
                break;

              case Status.ERROR:
                emit(PlayerListErrorState(event.message!));
            }
          }).onError((e, s) {
            emit(PlayerListErrorState(e.toString()));
          });
  }

  void removePlayer(Player item) {
    _deletePlayersByIdsUseCase.execute([item.id]).listen((event) {
      switch (event.status) {
        case Status.LOADING:
          emit(PlayerListLoadingState());
          break;

        case Status.SUCCESS:
          cachedPlayers?.remove(item);
          emit(PlayerListDataRemovedState(cachedPlayers!));
          break;

        case Status.ERROR:
          emit(PlayerListErrorState(event.message!));
      }
    });
  }
}
