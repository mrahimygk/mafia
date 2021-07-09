import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia/app/di.dart';
import 'package:mafia/common/base/base_page.dart';
import 'package:mafia/common/widgets/api_error_widget.dart';
import 'package:mafia/common/widgets/drawer.dart';
import 'package:mafia/feature/lists/data/items.dart';
import 'package:mafia/feature/lists/logic/all_list_cubit.dart';

class AllListPage extends BasePage<AllListCubit, AllListState, void> {
  final AllListCubit _cubit = serviceLocator.get<AllListCubit>();

  final VoidCallback onToggleTheme;
  final Function(int type) onDrawerItemClick;

  AllListPage(this.onToggleTheme, this.onDrawerItemClick, {Key? key})
      : super(key: key) {
    _cubit.getAllList();
  }

  @override
  Widget buildWidget(
    BuildContext context,
    TextDirection direction,
    bool isDarkMode,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text("allLists".tr()),
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
        builder: (BuildContext context, AllListState state) {
          if (state is AllListInitialState || state is AllListNavigationState) {
            return Container(color: Colors.white);
          }

          if (state is AllListLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is AllListNoDataState) {
            return Text("No data, maybe need to reinstall app or report a bug");
          }

          if (state is AllListErrorState) {
            return Center(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ApiErrorWidget(state.error, () {
                    _cubit.getAllList();
                  })),
            );
          }

          if (state is AllListDataReceivedState) {
            return _buildAllListView(state.listItems, direction, isDarkMode);
          }

          throw Exception("Please handle all states above $state");
        },
      ),
    );
  }

  @override
  AllListCubit getPageBloc() => _cubit;

  Widget _buildAllListView(
      List<ListItem> itemList, TextDirection direction, bool isDarkMode) {
    return ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          final item = itemList[index];
          return GestureDetector(
            onTapUp: (d) {
              Navigator.pushNamed(context, item.route);
            },
            child: ListTile(
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              title: Text(
                item.title.tr(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        });
  }
}
