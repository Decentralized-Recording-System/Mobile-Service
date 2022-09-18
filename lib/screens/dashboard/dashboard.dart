import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../widgets/index.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  static const String id = 'Dashboard';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Expanded(
              flex: 3,
              child: new Container(
                color: Color.fromARGB(255, 39, 179, 111),
              ),
            ),
            new Expanded(
              flex: 5,
              child: new Container(
                color: Colors.white,
              ),
            ),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.225,
          left: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width / 2,
          child: Container(
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: CircularPercentIndicator(
              radius: 90.0,
              lineWidth: 10.0,
              percent: 0.8,
              center: new Text(
                "80 point",
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 39, 179, 111)),
              ),
              backgroundColor: Color.fromARGB(255, 209, 238, 223),
              progressColor: Color.fromARGB(255, 39, 179, 111),
            ),
          ),
        ),
      ],
    ));
  }
}
