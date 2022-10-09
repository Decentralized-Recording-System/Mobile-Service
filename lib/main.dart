import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telemetics/screens/splash_init/splash_init.dart';

import 'logic/index.dart';
import 'repositories/login_repo.dart';
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
    LoginRepository loginRepository = LoginRepository();

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginCubitCubit(
              loginRepository: loginRepository,
            ),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue,
            ).copyWith(
              secondary: Colors.purple,
            ),
            textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.red)),
          ),
          title: 'First Flutter App',
          initialRoute: Splash.id,
          routes: AppRouter.routeScreens,
        ));
  }
}
