import 'dart:async';

import 'package:flutter/material.dart';
import 'package:two_be_wedd/utils/navigation_helper.dart';

import '../login_view/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkAdminLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        "assets/images/app_logo.png",
        scale: 1,
      )),
    );
  }

  _checkAdminLogin() {
    Timer(const Duration(seconds: 3), () async {
      NavigationHelper.pushReplacement(context, LoginView());
      // NavigationHelper.pushReplacement(context, const DashboardView());
    });
  }
}
