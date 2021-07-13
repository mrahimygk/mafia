import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia/app/di.dart';
import 'package:mafia/common/assets/role_images.dart';
import 'package:mafia/common/base/base_page.dart';
import 'package:mafia/common/widgets/api_error_widget.dart';
import 'package:mafia/common/widgets/empty_list_widget.dart';
import 'package:mafia/domain/model/role/role.dart';
import 'package:mafia/navigation/routes.dart';
import '../logic/role_list_cubit.dart';

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
        if (state is RoleListInitialState || state is RoleListNavigationState) {
          return Container(color: Colors.white);
        }

        if (state is RoleListLoadingState) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is RoleListNoDataState) {
          return Center(
            child: EmptyListWidget("addRoles", () {
              //TODO: add role dialog
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
    return ListView.builder(
      itemCount: roles.length,
        itemBuilder: (BuildContext context, int index){
      final item = roles[index];
      return Card(
        child: ListTile(
          onTap: (){
            Navigator.of(context).pushNamed(NavigationRoutes.ROLE_DETAILS, arguments: item);
          },
          title:  Text(item.name.tr()),
          trailing: Image.asset("$rolesPath/${item.name}_thumb.png", width: 32, height: 32,),
        ),
      );
    });
  }
}
