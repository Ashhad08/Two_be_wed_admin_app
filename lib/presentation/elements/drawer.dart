import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:two_be_wedd/infrastructure/models/admin_model.dart';
import 'package:two_be_wedd/infrastructure/services/system_services.dart';
import 'package:two_be_wedd/utils/extensions.dart';

import '../../infrastructure/providers/drawer_destination_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerDestinationProvider =
        context.watch<DrawerDestinationProvider>();
    return NavigationDrawer(
      selectedIndex: drawerDestinationProvider.index,
      onDestinationSelected: (index) =>
          drawerDestinationProvider.changeIndex(index, context),
      children: [
        StreamProvider.value(
            value: SystemServices().fetchCurrentAdmin(),
            initialData: AdminModel(),
            builder: (context, child) {
              final admin = context.watch<AdminModel>();
              return UserAccountsDrawerHeader(
                currentAccountPicture: const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/app_logo.png",
                    ),
                    backgroundColor: Colors.white,
                  ),
                ),
                accountName: Text(
                  admin.name ?? "",
                  style: context.textTheme.titleLarge!
                      .copyWith(color: Colors.white),
                ),
                accountEmail: Text(
                  admin.email ?? "",
                  style: context.textTheme.titleMedium!
                      .copyWith(color: Colors.white),
                ),
              );
            }),
        const NavigationDrawerDestination(
          icon: FaIcon(
            FontAwesomeIcons.gauge,
          ),
          label: Text(
            'Dashboard',
          ),
        ),
        const NavigationDrawerDestination(
          icon: FaIcon(
            FontAwesomeIcons.utensils,
          ),
          label: Text(
            'Hall Bookings',
          ),
        ),
        const NavigationDrawerDestination(
          icon: FaIcon(
            FontAwesomeIcons.calendarCheck,
          ),
          label: Text(
            'Confirmed Orders',
          ),
        ),
        const NavigationDrawerDestination(
          icon: FaIcon(
            FontAwesomeIcons.arrowRightFromBracket,
          ),
          label: Text(
            'LogOut',
          ),
        ),
      ],
    );
  }
}
