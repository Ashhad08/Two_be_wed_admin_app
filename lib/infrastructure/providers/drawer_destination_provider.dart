import 'package:flutter/material.dart';
import 'package:two_be_wedd/infrastructure/services/auth_services.dart';

import '../../presentation/views/confirmed_orders_view/confirmed_orders_view.dart';
import '../../presentation/views/dashboard_view/dashboard_view.dart';
import '../../presentation/views/hall_bookings_view/hall_bookings_view.dart';
import '../../utils/navigation_helper.dart';

class DrawerDestinationProvider extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  changeIndex(int index, BuildContext context) {
    if (index != 3) {
      _index = index;
      notifyListeners();
      switch (index) {
        case 0:
          NavigationHelper.pushReplacement(context, const DashboardView());
        case 1:
          NavigationHelper.pushReplacement(context, HallBookingsView());
        case 2:
          NavigationHelper.pushReplacement(context, ConfirmedOrdersView());
      }
    } else {
      AuthServices().logOut(context);
    }
  }
}
