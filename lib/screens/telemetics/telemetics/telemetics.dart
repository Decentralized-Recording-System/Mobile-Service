import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import '../../../model/index.dart';
import '../../../services/index.dart';
import '../../../services/index.dart';
import '../../../utils/private_keys/private_key.dart';
import '../../../widgets/index.dart';
import '../inedx.dart';

class Telemetics extends StatefulWidget {
  const Telemetics({
    Key? key,
  }) : super(key: key);
  static const String id = 'Telemetics';

  @override
  _TelemeticsState createState() => _TelemeticsState();
}

class _TelemeticsState extends State<Telemetics> {
  Web3Dart alte = Web3Dart();
  String text = "";
  bool backgroundService = false;
  @override
  void initState() {
    super.initState();
    if (mounted) {
      fff();
      setState(() {});
    }
  }

  void fff() async {
    await FlutterBackgroundService().isRunning().then((value) {
      if (!value) {
        setState(() {
          text = "Press to Start";
        });
      } else {
        setState(() {
          text = 'Press to Stop';
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 8,
              child: GestureDetector(
                onTap: () async {
                  final service = FlutterBackgroundService();
                  var isRunning = await service.isRunning();
                  if (isRunning) {
                    service.invoke("stopService");
                  } else {
                    service.startService();
                  }

                  if (!isRunning) {
                    text = 'Press to Stop';
                  } else {
                    text = 'Press to Start';
                  }
                  setState(() {});
                },
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: text == 'Press to Start'
                          ? Theme.of(context).primaryColor
                          : Colors.yellow,
                      width: 12,
                    ),
                  ),
                  child: Center(
                    child: Text(text,
                        style: TextStyle(
                            color: text == 'Press to Start'
                                ? Theme.of(context).primaryColor
                                : Colors.yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    TelemeticsButton(
                      onPressed: () {
                        Navigator.pushNamed(context, TelemeticsTransaction.id);
                      },
                      text: 'Send Transaction',
                    )
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
