import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia/app/di.dart';
import 'package:mafia/common/base/base_page.dart';
import 'package:mafia/common/widgets/api_error_widget.dart';
import 'package:mafia/common/widgets/drawer.dart';
import 'package:mafia/data/model/role/role.dart';
import 'package:mafia/feature/role/logic/role_list_cubit.dart';

class RoleListPage extends BasePage<RoleListCubit, RoleListState, void> {
  final RoleListCubit _cubit = serviceLocator.get<RoleListCubit>();

  final VoidCallback onToggleTheme;
  final Function(int type) onDrawerItemClick;

  RoleListPage(this.onToggleTheme, this.onDrawerItemClick, {Key? key})
      : super(key: key) {
    _cubit.getRoleList();
  }

  @override
  Widget buildWidget(
    BuildContext context,
    TextDirection direction,
    bool isDarkMode,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text("roleList".tr()),
      ),
      /*drawer: AppDrawer(
        onToggleTheme: onToggleTheme,
        onItemClick: onDrawerItemClick,
        onLanguageChanged: (Locale? locale) {
          localization.EasyLocalization.of(context)!.setLocale(locale!);
        },
      ),*/
      body: BlocBuilder(
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
            return Text("No data, add roles");
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
      ),
    );
  }

  @override
  RoleListCubit getPageBloc() => _cubit;

  Widget _buildRoleListView(
      List<Role> roles, TextDirection direction, bool isDarkMode) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.5,
        ),
        itemCount: roles.length,
        itemBuilder: (context, index) {
          final item = roles[index];
          return GestureDetector(
            onTapUp: (d) {},
            child: Text(
              "${item.name} (${item.id})",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        });
  }
}
