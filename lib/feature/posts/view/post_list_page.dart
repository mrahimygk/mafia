import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:mafia/app/di.dart';
import 'package:mafia/common/base/base_page.dart';
import 'package:mafia/common/widgets/drawer.dart';
import 'package:mafia/feature/posts/logic/post_list_cubit.dart';
import 'package:mafia/feature/posts/view/post_list_widget.dart';

class PostListPage extends BasePage<PostListCubit, PostListState, void> {
  final PostListCubit _cubit = serviceLocator.get<PostListCubit>();
  final VoidCallback onToggleTheme;

  PostListPage(this.onToggleTheme, {Key? key}) : super(key: key);

  @override
  Widget buildWidget(
    BuildContext context,
    TextDirection direction,
    bool isDarkMode,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appName".tr()),
      ),
      drawer: AppDrawer(
        onLanguageChanged: (Locale? locale) {
          localization.EasyLocalization.of(context)!.setLocale(locale!);
        },
        onToggleTheme: onToggleTheme,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: PostListWidget()),
        ],
      ),
    );
  }

  @override
  PostListCubit getPageBloc() => _cubit;
}
