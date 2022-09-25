import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

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
  late TelemeticsDatabase db;
  late Future<List<TelemeticsDatabaseModel>> books;
  ScoreCase caseProcess = ScoreCase();
  static const int numList = 500;
  List<double>? _accelerometerValues;
  List<double>? _userAccelerometerValues;
  List<double>? _gyroscopeValues;
  TelemeticsProcess telemetics = TelemeticsProcess(numList);
  late int currentScore = 0;

  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  @override
  Widget build(BuildContext context) {
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        .toList();
    if (accelerometer != null &&
        gyroscope != null &&
        userAccelerometer != null) {
      final list =
          telemetics.process(accelerometer, gyroscope, userAccelerometer);
      print(list);
      if (list.isNotEmpty) {
        caseProcess.getCase(list, db);
        db.create(const TelemeticsDatabaseModel(
            score: 11, highestValue: 12.0, lowestValue: 15.0));
        setState(() {
          books = db.readAllData();
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Example'),
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<TelemeticsDatabaseModel>>(
            future: books,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                      child: snapshot.data!.isNotEmpty
                          ? ListView.separated(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                TelemeticsDatabaseModel book =
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
                                          title: Text('${book.score}'),
                                          subtitle: Text(
                                              'hightestscore: ${book.highestValue}'),
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
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    db = TelemeticsDatabase.instance;
    books = db.readAllData();

    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
            // print(_accelerometerValues);
          });
        },
      ),
    );
    _streamSubscriptions.add(
      gyroscopeEvents.listen(
        (GyroscopeEvent event) {
          setState(() {
            _gyroscopeValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
    _streamSubscriptions.add(
      userAccelerometerEvents.listen(
        (UserAccelerometerEvent event) {
          setState(() {
            _userAccelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
  }
}
