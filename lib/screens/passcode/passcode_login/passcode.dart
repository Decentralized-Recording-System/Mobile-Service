import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/i18n/app_localizations.dart';
import '../../../logic/dashboard_cubit/dashboard_cubit_cubit.dart';
import '../../../widgets/index.dart';
import '../../bottom_navigator_bar/bottom_navigator_bar.dart';

class PassCode extends StatefulWidget {
  const PassCode({super.key});
  static const String id = 'PassCode';
  @override
  State<PassCode> createState() => _PassCodeState();
}

class _PassCodeState extends State<PassCode> {
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
          if (state is DashboardCubitInitial) {
            return Column(
              children: [
                Expanded(flex: 1, child: Container()),
                const Expanded(
                    flex: 2,
                    child: NumpadLogin(
                      length: 5,
                    ))
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
