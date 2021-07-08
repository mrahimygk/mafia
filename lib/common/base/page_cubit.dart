import 'package:mafia/common/base/page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PageCubit<T extends WidgetState> extends Cubit<T> {
  PageCubit(T initialState) : super(initialState);
}
