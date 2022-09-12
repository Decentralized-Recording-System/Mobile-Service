import 'package:flutter/material.dart';

import 'router/router.dart';
import 'screens/index.dart';

void main() {
  runApp(const MyApp());
}

// ส่วนของ Stateless widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.purple,
        ),
        textTheme: TextTheme(bodyText2: TextStyle(color: Colors.red)),
      ),
      title: 'First Flutter App',
      initialRoute: Launcher.id, // สามารถใช้ home แทนได้
      routes: AppRouter.routeScreens,
    );
  }
}
