import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:web3dart/web3dart.dart';

import '../../constants/i18n/index.dart';
import '../../constants/index.dart';
import '../../logic/dashboard_cubit/dashboard_cubit_cubit.dart';
import '../../logic/index.dart';
import '../../services/index.dart';
import '../../widgets/index.dart';

class History extends StatefulWidget {
  const History({super.key});
  static const String id = 'History';

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardCubitCubit, DashboardCubitState>(
        builder: (context, state) {
          if (state is DashBoardDataDrivingState) {
            return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "history of Safty score",
                    style: TextStyle(color: Colors.white),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.drivingDataList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HistoryBox(
                          date: state.drivingDataList[index].date.toString(),
                          score: state.drivingDataList[index].score.toString(),
                          braking:
                              state.drivingDataList[index].braking.toString(),
                          dangerousSpeed: state
                              .drivingDataList[index].dangerousSpeed
                              .toString(),
                          averageSpeed: state
                              .drivingDataList[index].averageSpeed
                              .toString(),
                          dangerousBrake: state
                              .drivingDataList[index].dangerousBrake
                              .toString(),
                          dangerousTurn: state
                              .drivingDataList[index].dangerousTurn
                              .toString(),
                          drivingTime: state.drivingDataList[index].drivingTime
                              .toString(),
                        );
                      }),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
