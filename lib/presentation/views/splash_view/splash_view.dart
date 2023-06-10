import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/services/splash_services.dart';
import '../../../utils/navigation_helper.dart';
import '../add_hall_view/add_hall_view.dart';
import '../admin_auth_view/admin_auth_view.dart';
import '../dashboard_view/dashboard_view.dart';

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
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        bool isHallCreated = await SplashServices.isAdminCreatedHall();
        if (isHallCreated) {
          // ignore: use_build_context_synchronously
          NavigationHelper.pushReplacement(
            context,
            DashboardView(),
          );
        } else {
          // ignore: use_build_context_synchronously
          NavigationHelper.pushReplacement(
            context,
            const AddHallView(),
          );
        }
      } else {
        NavigationHelper.pushReplacement(
          context,
          const AdminAuthView(),
        );
      }
    });
  }
}
