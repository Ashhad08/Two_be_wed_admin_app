import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'infrastructure/providers/drawer_destination_provider.dart';
import 'infrastructure/providers/hall_images_provider.dart';
import 'infrastructure/providers/loading_helper.dart';
import 'infrastructure/services/notifications_service.dart';
import 'presentation/views/splash_view/splash_view.dart';
import 'utils/app_theme.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationsService()
      .flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(NotificationsService().channel);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    NotificationsService().requestPermissions();
    NotificationsService().notificationsInitialize(context);
    NotificationsService().notificationsOnMessage(context);
  }

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
