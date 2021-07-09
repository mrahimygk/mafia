import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia/app/di.dart';
import 'package:mafia/common/base/base_page.dart';
import 'package:mafia/common/widgets/api_error_widget.dart';
import 'package:mafia/common/widgets/empty_list_widget.dart';
import 'package:mafia/data/model/role/role.dart';
import 'package:mafia/feature/role/logic/role_list_cubit.dart';

class RoleListWidget extends BasePage<RoleListCubit, RoleListState, void> {
  final RoleListCubit _cubit = serviceLocator.get<RoleListCubit>();

  final VoidCallback onToggleTheme;
  final Function(int type) onDrawerItemClick;

  RoleListWidget(this.onToggleTheme, this.onDrawerItemClick, {Key? key})
      : super(key: key) {
    _cubit.getRoleList();
  }

  @override
  Widget buildWidget(
    BuildContext context,
    TextDirection direction,
    bool isDarkMode,
  ) {
    return BlocBuilder(
        bloc: _cubit,
        buildWhen: (previousState, currentState) {
          return previousState != currentState;
        },
        builder: (BuildContext context, RoleListState state) {
          if (state is RoleListInitialState ||
              state is RoleListNavigationState) {
            return Container(color: Colors.white);
          }

          if (state is RoleListLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is RoleListNoDataState) {
            return Center(
              child: EmptyListWidget("addRoles", () {
                //TODO: add players dialog
              }),
            );
          }

          if (state is RoleListErrorState) {
            return Center(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ApiErrorWidget(state.error, () {
                    _cubit.getRoleList();
                  })),
            );
          }

          if (state is RoleListDataReceivedState) {
            return _buildRoleListView(state.roles, direction, isDarkMode);
          }

          if (state is RoleListDataFilledState) {
            return _buildRoleListView(state.roles, direction, isDarkMode);
          }

          throw Exception("Please handle all states above $state");
        },
      );
  }

  @override
  RoleListCubit getPageBloc() => _cubit;

  Widget _buildRoleListView(
      List<Role> roles, TextDirection direction, bool isDarkMode) {
    return SingleChildScrollView(
      child: Wrap(
        children: _buildRoleChildren(roles, direction, isDarkMode),
      ),
    );
  }

  List<Widget> _buildRoleChildren(
      List<Role> roles, TextDirection direction, bool isDarkMode) {
    final List<Widget> list = [];
    roles.forEach((item) {
      list.add(GestureDetector(
        onTapUp: (d) {},
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            decoration: BoxDecoration(
              color: item.groupId == 1
                  ? Colors.red.shade100
                  : item.groupId == 2
                      ? Colors.green.shade100
                      : Colors.yellow.shade100,
              border: Border(),
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            padding: EdgeInsets.all(6.0),
            child: Text(
              "${item.name.tr()}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ));
    });

    return list;
  }
}
