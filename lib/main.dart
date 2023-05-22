import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:telemetics/screens/splash_init/splash_init.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:telemetics/services/local_notification/local_notification.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'constants/i18n/index.dart';
import 'constants/index.dart';
import 'logic/dashboard_cubit/dashboard_cubit_cubit.dart';
import 'logic/index.dart';
import 'model/index.dart';
import 'repositories/index.dart';
import 'repositories/login_repo.dart';
import 'router/router.dart';
import 'screens/index.dart';
import 'services/index.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'MY FOREGROUND SERVICE', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: false,
      isForegroundMode: true,

      notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: false,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );

  service.invoke("stopService");
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  List<double>? _accelerometerValues;
  List<double>? _userAccelerometerValues;
  List<double>? _gyroscopeValues;
  List<double>? _magnetometerValues;
  // Location Locations = Location();
  double speed = 0;
  bool speedDuration = false;
  double highestSpeed = 0;
  const int numList = 200;
  late TelemeticsDatabase db = TelemeticsDatabase.instance;
  late TelemeticsTestDatabase dbTest = TelemeticsTestDatabase.instance;
  TelemeticsProcess telemetics = TelemeticsProcess(numList);
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually
  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    service.stopSelf();
  });

  // bring to foreground
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        .toList();

    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        _streamSubscriptions.add(
          accelerometerEvents.listen(
            (AccelerometerEvent event) {
              _accelerometerValues = <double>[event.x, event.y, event.z];
            },
          ),
        );
        _streamSubscriptions.add(
          gyroscopeEvents.listen(
            (GyroscopeEvent event) {
              _gyroscopeValues = <double>[event.x, event.y, event.z];
            },
          ),
        );
        _streamSubscriptions.add(
          userAccelerometerEvents.listen(
            (UserAccelerometerEvent event) {
              _userAccelerometerValues = <double>[event.x, event.y, event.z];
            },
          ),
        );
        flutterLocalNotificationsPlugin.show(
          888,
          'COOL SERVICE',
          'Awesome ${DateTime.now()}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'my_foreground',
              'MY FOREGROUND SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );
      }
    }
    // var loc = await Locations.getLocation();
    // speed = loc.speed!;
    // if (speed >= 120 && !speedDuration) {
    //   highestSpeed = speed;
    //   speedDuration = true;
    // }
    // if (speedDuration && highestSpeed <= 80) {
    //   db.create(const TelemeticsDatabaseModel(
    //       score: 1, highestValue: 0, lowestValue: 0));
    //   highestSpeed = 0;
    //   speedDuration = false;
    // }

    if (accelerometer != null &&
        gyroscope != null &&
        userAccelerometer != null) {
      var hashBrakeValue = telemetics.telemeticsProcessing(
          accelerometer, gyroscope, userAccelerometer);

      if (hashBrakeValue.isNotEmpty) {
        print("get data");
        // dbTest.create(TelemeticsTestDatabaseModel(list: list.toString()));
        // caseProcess.getCase(list, db);
        db.create(TelemeticsDatabaseModel(
            score: hashBrakeValue[0],
            brakingValue: hashBrakeValue[1],
            dangerousBrakeValue: hashBrakeValue[2],
            dangerousTurnValue: 12));
      }
    }

    /// you can see this log in logcat
    // test using external plugin
    final deviceInfo = DeviceInfoPlugin();
    String? device;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.model;
    }

    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      device = iosInfo.model;
    }

    service.invoke(
      'update',
      {
        "accelerometer": accelerometer,
        "gyroscope": gyroscope,
        "userAccelerometer": userAccelerometer,
      },
    );
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // LocalNotificationService.initialize();
  await initializeService();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LoginRepository loginRepository = LoginRepository();
  SettingRepository settingRepository = SettingRepository();
  DrivingRepository drivingRepository = DrivingRepository();
  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage().then((message) => {
          if (message != null)
            {Navigator.of(context).pushNamed(message.data["route"])}
        });
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
      }
      // LocalNotificationService.display(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      Navigator.of(context).pushNamed(routeFromMessage);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginCubitCubit(
              loginRepository: loginRepository,
            ),
          ),
          BlocProvider(
            create: (context) =>
                SettingCubitCubit(settingRepository: settingRepository),
          ),
          BlocProvider(
            create: (context) =>
                DashboardCubitCubit(drivingRepository: drivingRepository),
          ),
        ],
        child: BlocBuilder<SettingCubitCubit, StateTheme>(
            builder: (context, state) {
          context.read<SettingCubitCubit>().setInitialState();
          return MaterialApp(
            supportedLocales: LocaleSupport.localeSupport,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: state.locale,
            themeMode: ThemeMode.system,
            theme: state.isDarkTheme
                ? ThemeClass.lightTheme
                : ThemeClass.darkTheme,
            title: 'First Flutter App',
            initialRoute: Splash.id,
            routes: AppRouter.routeScreens,
          );
        }));
  }
}
