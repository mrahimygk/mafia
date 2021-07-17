import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mafia/app/di.dart';
import 'package:mafia/common/assets/role_images.dart';
import 'package:mafia/common/base/base_page.dart';
import 'package:mafia/common/widgets/api_error_widget.dart';
import 'package:mafia/common/widgets/empty_list_widget.dart';
import 'package:mafia/domain/model/role/role.dart';

import '../logic/role_details_cubit.dart';

class RoleDetailsWidget
    extends BasePage<RoleDetailsCubit, RoleDetailsState, void> {
  final RoleDetailsCubit _cubit = serviceLocator.get<RoleDetailsCubit>();

  final Role role;

  RoleDetailsWidget(this.role, {Key? key}) : super(key: key) {
    _cubit.getRoleDetails(role, false);
  }

  @override
  Widget buildWidget(
    BuildContext context,
    TextDirection direction,
    bool isDarkMode,
  ) {
    final role = ModalRoute.of(context)?.settings.arguments as Role;
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
    return NestedScrollView(
        headerSliverBuilder: (c, b) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 156,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("roleDetails".tr()),
                background: Image.asset(
                  "$rolesPath/${role.name}.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                role.name.tr(),
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            Text(role.description.tr()), //TODO: add description if empty
          ],
        ));
  }
}
