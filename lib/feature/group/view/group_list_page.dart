import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia/app/di.dart';
import 'package:mafia/common/base/base_page.dart';
import 'package:mafia/common/widgets/api_error_widget.dart';
import 'package:mafia/data/model/role/group.dart';
import 'package:mafia/feature/group/logic/group_list_cubit.dart';

class GroupListPage extends BasePage<GroupListCubit, GroupListState, void> {
  final GroupListCubit _cubit = serviceLocator.get<GroupListCubit>();

  GroupListPage({Key? key}) : super(key: key) {
    _cubit.getGroupList();
  }

  @override
  Widget buildWidget(
    BuildContext context,
    TextDirection direction,
    bool isDarkMode,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text("groupList".tr()),
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
        builder: (BuildContext context, GroupListState state) {
          if (state is GroupListInitialState ||
              state is GroupListNavigationState) {
            return Container(color: Colors.white);
          }

          if (state is GroupListLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is GroupListNoDataState) {
            return Text("No data, add groups");
          }

          if (state is GroupListErrorState) {
            return Center(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ApiErrorWidget(state.error, () {
                    _cubit.getGroupList();
                  })),
            );
          }

          if (state is GroupListDataReceivedState) {
            return _buildGroupListView(state.groups, direction, isDarkMode);
          }

          throw Exception("Please handle all states above $state");
        },
      ),
    );
  }

  @override
  GroupListCubit getPageBloc() => _cubit;

  Widget _buildGroupListView(
      List<Group> groups, TextDirection direction, bool isDarkMode) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.5,
        ),
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final item = groups[index];
          return GestureDetector(
            onTapUp: (d) {
              // _cubit.navigateToGroupDetails(item);
            },
            child: Text(
              "${item.name} (${item.id})",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        });
  }
}
