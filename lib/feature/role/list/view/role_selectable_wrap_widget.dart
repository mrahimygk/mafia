import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia/app/di.dart';
import 'package:mafia/common/base/base_page.dart';
import 'package:mafia/common/widgets/api_error_widget.dart';
import 'package:mafia/common/widgets/empty_list_widget.dart';
import 'package:mafia/common/widgets/selectable_item_widget.dart';
import 'package:mafia/domain/model/role/role.dart';
import 'package:mafia/navigation/routes.dart';

import '../logic/role_list_cubit.dart';

class RoleSelectableWrapWidget
    extends BasePage<RoleListCubit, RoleListState, void> {
  final RoleListCubit _cubit = serviceLocator.get<RoleListCubit>();

  RoleSelectableWrapWidget({Key? key}) : super(key: key) {
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
        if (state is RoleListInitialState || state is RoleListNavigationState) {
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
          return _buildRoleListView(
              state.roles, direction, isDarkMode, context);
        }

        if (state is RoleListDataFilledState) {
          return _buildRoleListView(
              state.roles, direction, isDarkMode, context);
        }

        throw Exception("Please handle all states above $state");
      },
    );
  }

  @override
  RoleListCubit getPageBloc() => _cubit;

  Widget _buildRoleListView(List<Role> roles, TextDirection direction,
      bool isDarkMode, BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: _buildRoleChildren(roles, direction, isDarkMode, context),
        ),
      ),
    );
  }

  List<Widget> _buildRoleChildren(List<Role> roles, TextDirection direction,
      bool isDarkMode, BuildContext context) {
    final List<Widget> list = [];
    roles.forEach((item) {
      if (item.name == "mafia" || item.name == "citizen") {
        item.isSelected = true;
      }
      list.add(SelectableItemWidget(
        item: item,
        onLongPress: () {
          Navigator.pushNamed(context, NavigationRoutes.ROLE_DETAILS,
              arguments: item);
        },
      ));
    });

    return list;
  }

  List<Role>? getSelectedRoles() => _cubit.getSelectedRoles();
}
