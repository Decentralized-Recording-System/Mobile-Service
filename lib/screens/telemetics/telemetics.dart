import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Telemetics extends StatefulWidget {
  const Telemetics({
    Key? key,
  }) : super(key: key);
  static const String id = 'Telemetics';

  @override
  _TelemeticsState createState() => _TelemeticsState();
}

class _TelemeticsState extends State<Telemetics> {
  static const int _snakeRows = 20;
  static const int _snakeColumns = 20;
  static const double _snakeCellSize = 10.0;

  List<double>? _accelerometerValues;
  List<double>? _userAccelerometerValues;
  List<double>? _gyroscopeValues;
  List<double>? _magnetometerValues;
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
    final magnetometer =
        _magnetometerValues?.map((double v) => v.toStringAsFixed(1)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black38),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Accelerometer: $accelerometer'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('UserAccelerometer: $userAccelerometer'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Gyroscope: $gyroscope'),
              ],
            ),
          ),
        ],
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
    Timer.periodic(const Duration(seconds: 1), (_) {
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
      print(_accelerometerValues);
      print(_gyroscopeValues);
      print(_userAccelerometerValues);
    });
  }
}
