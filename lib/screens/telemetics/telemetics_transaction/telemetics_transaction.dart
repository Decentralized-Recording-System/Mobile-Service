import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/dashboard_cubit/dashboard_cubit_cubit.dart';
import '../../../model/index.dart';
import '../../../services/index.dart';
import '../../../utils/private_keys/private_key.dart';
import '../../../widgets/index.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class TelemeticsTransaction extends StatefulWidget {
  const TelemeticsTransaction({super.key});
  static const String id = 'TelemeticsTransaction';
  @override
  State<TelemeticsTransaction> createState() => _TelemeticsTransactionState();
}

class _TelemeticsTransactionState extends State<TelemeticsTransaction> {
  late TelemeticsDatabase db;
  late TelemeticsAccelerationDatabase dbAcc;
  late Future<List<TelemeticsDatabaseModel>> brakingScore;
  late Future<List<TelemeticsAccelerationModel>> accelerationScore;
  late int resultOfScoreAcceleration = 0;
  late int resultOfScoreBraking = 0;
  List brakingScoreList = [];
  List accelerationScoreList = [];
  double brakingValue = 0;
  double dangerousBrakeValue = 0;
  double dangerousTurnValue = 0;
  double score = 0;
  double dangerousSpeedValue = 0;
  double averageSpeedValue = 0;
  double drivingTimeValue = 0;
  Map<dynamic, dynamic> objectBraking = {};
  Map<dynamic, dynamic> objectAcc = {};
  Map<dynamic, dynamic> objectSendTransaction = {};
  @override
  void initState() {
    super.initState();
    db = TelemeticsDatabase.instance;
    dbAcc = TelemeticsAccelerationDatabase.instance;
    WidgetsFlutterBinding.ensureInitialized();
    accelerationScore = dbAcc.readAllData();

    brakingScore = db.readAllData();
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColorLight,
          content: const SingleChildScrollView(
            child: Center(
              child: Text(
                  "Uploaded! wait about 1-2 minutes before reading your data"),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Exit',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.subtitle1?.color),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Information')),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "Braking Table",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.subtitle1?.color),
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder<List<TelemeticsDatabaseModel>>(
                      future: brakingScore,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty) {
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  TelemeticsDatabaseModel braking =
                                      snapshot.data![index];
                                  return TelemeticsHistoryBox(
                                    deductedScore: braking.score.toString(),
                                    date: '26/04/2023',
                                    title: 'Braking',
                                    titleValue: braking.brakingValue.toString(),
                                  );
                                });
                          } else {
                            return Container(
                                width: 350,
                                height: 50,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: Center(
                                  child: Text(
                                    "Empty",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.color),
                                  ),
                                ));
                          }
                        } else {
                          return const Text("Empty");
                        }
                      }),
                  const SizedBox(height: 10),
                  Text(
                    "Acceleration Table",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.subtitle1?.color),
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder<List<TelemeticsAccelerationModel>>(
                      future: accelerationScore,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty) {
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  TelemeticsAccelerationModel
                                      accelerationScore = snapshot.data![index];

                                  return TelemeticsHistoryBox(
                                    deductedScore:
                                        accelerationScore.score.toString(),
                                    date: '14/12/2565',
                                    title: 'Acceleration',
                                    titleValue: accelerationScore.averageSpeed
                                        .toString(),
                                  );
                                });
                          } else {
                            return Container(
                                width: 350,
                                height: 50,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: Center(
                                  child: Text(
                                    "Empty",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.color),
                                  ),
                                ));
                          }
                        } else {
                          return const Text("Empty");
                        }
                      }),
                  const SizedBox(height: 10),
                  TelemeticsButton(
                    onPressed: () async {
                      try {
                        await dbAcc.readAllData().then((value) {
                          dangerousSpeedValue = 0;
                          averageSpeedValue = 0;
                          drivingTimeValue = 0;
                          for (var element in value) {
                            dangerousSpeedValue += element.dangerousSpeed;
                            averageSpeedValue += element.averageSpeed;
                            drivingTimeValue += element.drivingTime;
                            score += element.score;
                          }
                          objectAcc = {
                            "dangerousSpeed": dangerousSpeedValue.toInt(),
                            "averageSpeed": averageSpeedValue.toString(),
                            "drivingTime": drivingTimeValue.toInt(),
                          };
                        });
                        await db.readAllData().then((value) {
                          brakingValue = 0;
                          dangerousBrakeValue = 0;
                          dangerousTurnValue - 0;
                          for (var element in value) {
                            brakingValue += element.brakingValue;
                            dangerousBrakeValue += element.dangerousBrakeValue;
                            dangerousTurnValue += element.dangerousTurnValue;
                            score += element.score;
                          }
                          objectBraking = {
                            "braking": brakingValue.toInt(),
                            "dangerousBrake": dangerousBrakeValue.toInt(),
                            "dangerousTurn": dangerousTurnValue.toInt(),
                            "date": "26/4/2566",
                            "score": score.toInt(),
                          };
                          score = 0;
                        });
                        objectSendTransaction = {
                          "data": [
                            {...objectAcc, ...objectBraking}
                          ]
                        };
                        // ignore: use_build_context_synchronously
                        context
                            .read<DashboardCubitCubit>()
                            .funcAddDataDriving(objectSendTransaction);

                        print(objectSendTransaction);
                        // _showMyDialog();
                      } catch (e) {
                        print(e.toString());
                      }
                      // web3Function.getPrivateKey();
                      // sendData('0x2c41E9c7A248d955493Ba6D8A26722ee3dB9631f');
                    },
                    text: 'Send Transaction',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
