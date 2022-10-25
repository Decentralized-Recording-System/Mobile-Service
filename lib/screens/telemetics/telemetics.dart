import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import '../../model/index.dart';
import '../../services/index.dart';

class Telemetics extends StatefulWidget {
  const Telemetics({
    Key? key,
  }) : super(key: key);
  static const String id = 'Telemetics';

  @override
  _TelemeticsState createState() => _TelemeticsState();
}

class _TelemeticsState extends State<Telemetics> {
  late TelemeticsTestDatabase db;
  late Future<List<TelemeticsTestDatabaseModel>> books;
  String text = "Start Service";
  // ScoreCase caseProcess = ScoreCase();
  // static const int numList = 500;
  // List<double>? _accelerometerValues;
  // List<double>? _userAccelerometerValues;
  // List<double>? _gyroscopeValues;
  // TelemeticsProcess telemetics = TelemeticsProcess(numList);
  // late int currentScore = 0;

  // final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  @override
  Widget build(BuildContext context) {
    // final accelerometer =
    //     _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    // final gyroscope =
    //     _gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();
    // final userAccelerometer = _userAccelerometerValues
    //     ?.map((double v) => v.toStringAsFixed(1))
    //     .toList();
    // if (accelerometer != null &&
    //     gyroscope != null &&
    //     userAccelerometer != null) {
    //   final list =
    //       telemetics.process(accelerometer, gyroscope, userAccelerometer);
    //   print(list);
    //   if (list.isNotEmpty) {
    //     caseProcess.getCase(list, db);
    //     db.create(const TelemeticsDatabaseModel(
    //         score: 11, highestValue: 12.0, lowestValue: 15.0));
    //     setState(() {
    //       books = db.readAllData();
    //     });
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Example'),
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<TelemeticsTestDatabaseModel>>(
            future: books,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final service = FlutterBackgroundService();
                        var isRunning = await service.isRunning();
                        if (isRunning) {
                          service.invoke("stopService");
                        } else {
                          service.startService();
                        }

                        if (!isRunning) {
                          text = 'Stop Service';
                        } else {
                          text = 'Start Service';
                        }
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      ),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: snapshot.data!.isNotEmpty
                          ? ListView.separated(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                TelemeticsTestDatabaseModel book =
                                    snapshot.data![index];

                                Widget card;
                                card = Card(
                                    margin: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: IconButton(
                                            onPressed: () => {},
                                            icon: const Icon(Icons.edit),
                                          ),
                                          title: Text('${book.id}'),
                                          subtitle: Text(
                                              'hightestscore: ${book.list}'),
                                          trailing: IconButton(
                                            onPressed: () => {},
                                            icon: const Icon(Icons.delete),
                                          ),
                                        ),
                                      ],
                                    ));
                                return card;
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(),
                            )
                          : const Center(child: Text('No items')),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                // กรณี error
                return Text('${snapshot.error}');
              }

              return const RefreshProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // for (final subscription in _streamSubscriptions) {
    //   subscription.cancel();
    // }
  }

  @override
  void initState() {
    super.initState();
    db = TelemeticsTestDatabase.instance;
    books = db.readAllData();

    // _streamSubscriptions.add(
    //   accelerometerEvents.listen(
    //     (AccelerometerEvent event) {
    //       setState(() {
    //         _accelerometerValues = <double>[event.x, event.y, event.z];
    //         // print(_accelerometerValues);
    //       });
    //     },
    //   ),
    // );
    // _streamSubscriptions.add(
    //   gyroscopeEvents.listen(
    //     (GyroscopeEvent event) {
    //       setState(() {
    //         _gyroscopeValues = <double>[event.x, event.y, event.z];
    //       });
    //     },
    //   ),
    // );
    // _streamSubscriptions.add(
    //   userAccelerometerEvents.listen(
    //     (UserAccelerometerEvent event) {
    //       setState(() {
    //         _userAccelerometerValues = <double>[event.x, event.y, event.z];
    //       });
    //     },
    //   ),
    // );
  }
}
