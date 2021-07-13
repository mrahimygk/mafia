import 'package:mafia/common/base/page_cubit.dart';
import 'package:mafia/common/base/page_state.dart';

part 'game_setup_state.dart';

class GameSetupCubit extends PageCubit<GameSetupState> {
  GameSetupCubit() : super(GameSetupInitialState());
}
