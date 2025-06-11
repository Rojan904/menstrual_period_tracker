import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:menstraul_period_tracker/auth/signup/model/user.dart';
import 'package:menstraul_period_tracker/home/home_page.dart';
import 'package:menstraul_period_tracker/home/home_screen.dart';
import 'package:menstraul_period_tracker/home/map_screen.dart';
import 'package:menstraul_period_tracker/home/screen_test.dart';
import 'package:menstraul_period_tracker/logs/model/logs_model.dart';
import 'package:menstraul_period_tracker/notification/notification_api.dart';
import 'package:menstraul_period_tracker/shared/global.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //registers the adapter that is created after generating model class with build runner
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(LogsModelAdapter());
  // Hive.registerAdapter(PeriodCycleAdapter());
  await Hive.openBox<User>('users');
  await Hive.openBox<LogsModel>('periodsLogs');
  await Hive.openBox('periodsData');
  await Hive.openBox('common');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    tz.initializeTimeZones();
    requestNotificationPermissions();
    super.initState();
  }

  Future<void> requestNotificationPermissions() async {
    final PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      NotificationApi.init();
    } else if (status.isDenied) {
      await Permission.notification.request();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      scaffoldMessengerKey: snackbarKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  ProductDetailss(),
    );
  }
}
