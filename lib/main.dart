import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'infrastructure/providers/drawer_destination_provider.dart';
import 'infrastructure/providers/hall_images_provider.dart';
import 'infrastructure/providers/loading_helper.dart';
import 'presentation/views/splash_view/splash_view.dart';
import 'utils/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DrawerDestinationProvider()),
        ChangeNotifierProvider(create: (_) => LoadingHelper()),
        ChangeNotifierProvider(create: (_) => HallImagesProvider()),
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
