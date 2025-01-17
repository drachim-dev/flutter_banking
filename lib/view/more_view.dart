import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking/auto_router.gr.dart';
import 'package:flutter_banking/common/dimens.dart';

class MoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('More'),
    );
  }

  ListView _buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: Dimens.listVerticalPadding),
      children: [
        ListTile(
            leading: Icon(Icons.settings),
            title: Text('Preferences'),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: Dimens.listItemPaddingHorizontal,
                vertical: Dimens.listItemPaddingVertical),
            onTap: () =>
                ExtendedNavigator.of(context).push(Routes.preferencesView)),
        ListTile(
          leading: Icon(Icons.place),
          title: Text('ATM map'),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: Dimens.listItemPaddingHorizontal,
              vertical: Dimens.listItemPaddingVertical),
          onTap: () => ExtendedNavigator.of(context).push(Routes.atmMapView),
        ),
        ListTile(
          leading: Icon(Icons.insert_drive_file),
          title: Text('Documents'),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: Dimens.listItemPaddingHorizontal,
              vertical: Dimens.listItemPaddingVertical),
          onTap: () {},
        ),
      ],
    );
  }
}
