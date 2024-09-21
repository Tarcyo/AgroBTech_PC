import 'package:flutter/material.dart';
import 'tabBarController.dart';

import 'pages/commoditie/commoditieScreen.dart';
import 'pages/groups/groupsScreen.dart';
import 'pages/settings/settings.dart';


import 'pages/dashboard/dashboard.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarController(
      items: [
     
        PersistentTabItem(
          title: 'Dashboard',
          tab: const DashboardScreenTab(),
          icon: Icons.home,
        ),
        PersistentTabItem(
          title: 'Commodities',
          tab: const CommoditieScreenTab(),
          icon: Icons.wallet,
        ),
        PersistentTabItem(
          title: 'Chat',
          tab: const GroupsScreenTab(),
          icon: Icons.chat,
        ),
        PersistentTabItem(
          title: 'Settings',
          tab: const SettingsScreenTab(),
          icon: Icons.settings,
        ),
      ],
    );
  }
}

class HomeScreenTab extends StatefulWidget {
  const HomeScreenTab({Key? key}) : super(key: key);

  @override
  _HomeScreenTabState createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<HomeScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Dashboard();
  }

  @override
  bool get wantKeepAlive => true;
}

class DashboardScreenTab extends StatefulWidget {
  const DashboardScreenTab({Key? key}) : super(key: key);

  @override
  _DashboardScreenTabState createState() => _DashboardScreenTabState();
}

class _DashboardScreenTabState extends State<DashboardScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Dashboard();
  }

  @override
  bool get wantKeepAlive => true;
}

class SettingsScreenTab extends StatefulWidget {
  const  SettingsScreenTab({Key? key}) : super(key: key);

  @override
  _SettingsScreenTabState createState() => _SettingsScreenTabState();
}

class _SettingsScreenTabState extends State<SettingsScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Settings();
  }

  @override
  bool get wantKeepAlive => true;
}

class GroupsScreenTab extends StatefulWidget {
  const GroupsScreenTab({Key? key}) : super(key: key);

  @override
  _GroupsScreenTabState createState() => _GroupsScreenTabState();
}

class _GroupsScreenTabState extends State<GroupsScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GroupsScreen();
  }

  @override
  bool get wantKeepAlive => true;
}

class CommoditieScreenTab extends StatefulWidget {
  const CommoditieScreenTab({Key? key}) : super(key: key);

  @override
  _CommoditieScreenTabState createState() => _CommoditieScreenTabState();
}

class _CommoditieScreenTabState extends State<CommoditieScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CommoditiesScreen();
  }

  @override
  bool get wantKeepAlive => true;
}