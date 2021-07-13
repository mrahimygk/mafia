import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:mafia/domain/model/role/role.dart';

import './role_details_widget.dart';

class RoleDetailsPage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final Function(int type) onDrawerItemClick;

  RoleDetailsPage(
    this.onToggleTheme,
    this.onDrawerItemClick, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final role = ModalRoute.of(context)?.settings.arguments as Role;
    return Scaffold(
      appBar: AppBar(
        title: Text("roleDetails".tr()),
      ),
      body: RoleDetailsWidget(onToggleTheme, onDrawerItemClick, role),
    );
  }
}
