import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'infrastructure/providers/drawer_destination_provider.dart';
import 'presentation/views/splash_view/splash_view.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DrawerDestinationProvider()),
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: MaterialApp(
          title: 'Two be Wedd',
          theme: AppTheme.lightTheme(context),
          debugShowCheckedModeBanner: false,
          darkTheme: AppTheme.darkTheme(context),
          home: const SplashView(),
        ),
      ),
    );
  }
}
