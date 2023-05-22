import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/dashboard_cubit/dashboard_cubit_cubit.dart';
import '../../../widgets/index.dart';
import '../../bottom_navigator_bar/bottom_navigator_bar.dart';

class PassCodeSetting extends StatefulWidget {
  const PassCodeSetting({super.key});
  static const String id = 'PassCodeSetting';
  @override
  State<PassCodeSetting> createState() => _PassCodeSettingState();
}

class _PassCodeSettingState extends State<PassCodeSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DashboardCubitCubit, DashboardCubitState>(
        listener: (context, state) {
          if (state is DashBoardDataDrivingResultState) {
            Navigator.pushReplacementNamed(context, Launcher.id);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(flex: 1, child: Container()),
              const Expanded(
                  flex: 2,
                  child: Numpad(
                    length: 5,
                  ))
            ],
          );
        },
      ),
    );
  }
}
