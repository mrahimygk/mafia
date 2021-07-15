import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import './role_list_widget.dart';

class RoleListPage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final Function(int type) onDrawerItemClick;

  RoleListPage(this.onToggleTheme, this.onDrawerItemClick, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("roleList".tr()),
      ),
      body: RoleListWidget(
        onToggleTheme,
        onDrawerItemClick,
      ),
    );
  }
}