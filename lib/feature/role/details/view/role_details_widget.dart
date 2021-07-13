import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia/app/di.dart';
import 'package:mafia/common/base/base_page.dart';
import 'package:mafia/common/widgets/api_error_widget.dart';
import 'package:mafia/common/widgets/empty_list_widget.dart';
import 'package:mafia/domain/model/role/role.dart';

import '../logic/role_details_cubit.dart';

class RoleDetailsWidget
    extends BasePage<RoleDetailsCubit, RoleDetailsState, void> {
  final RoleDetailsCubit _cubit = serviceLocator.get<RoleDetailsCubit>();

  final VoidCallback onToggleTheme;
  final Function(int type) onDrawerItemClick;
  final Role role;

  RoleDetailsWidget(this.onToggleTheme, this.onDrawerItemClick, this.role,
      {Key? key})
      : super(key: key) {
    _cubit.getRoleDetails(role, false);
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
      builder: (BuildContext context, RoleDetailsState state) {
        if (state is RoleDetailsInitialState ||
            state is RoleDetailsNavigationState) {
          return Container(color: Colors.white);
        }

        if (state is RoleDetailsLoadingState) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is RoleDetailsNoDataState) {
          return Center(
            child: EmptyListWidget("addRoles", () {
              //TODO: add role dialog
            }),
          );
        }

        if (state is RoleDetailsErrorState) {
          return Center(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ApiErrorWidget(state.error, () {
                  _cubit.getRoleDetails(role, true);
                })),
          );
        }

        if (state is RoleDetailsDataReceivedState) {
          return _buildRoleDetailsView(state.role, direction, isDarkMode);
        }

        if (state is RoleDetailsPreloadedState) {
          return _buildRoleDetailsView(state.role, direction, isDarkMode);
        }

        if (state is RoleDetailsDataFilledState) {
          return _buildRoleDetailsView(state.role, direction, isDarkMode);
        }

        throw Exception("Please handle all states above $state");
      },
    );
  }

  @override
  RoleDetailsCubit getPageBloc() => _cubit;

  Widget _buildRoleDetailsView(
      Role role, TextDirection direction, bool isDarkMode) {
    return Column(
      children: [Image.asset(role.name)],
    );
  }
}
