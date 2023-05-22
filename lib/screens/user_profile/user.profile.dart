import 'package:flutter/material.dart';
import 'package:telemetics/widgets/index.dart';

import '../../model/index.dart';
import '../../services/index.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});
  static const String id = 'UserProfile';
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late TelemeticsDatabase db;
  late TelemeticsAccelerationDatabase dbAcc;
  @override
  void initState() {
    super.initState();
    db = TelemeticsDatabase.instance;
    dbAcc = TelemeticsAccelerationDatabase.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo')),
      body: Column(children: [
        TelemeticsButton(
            onPressed: () {
              dbAcc.create(TelemeticsAccelerationModel(
                score: 1,
                averageSpeed: 80,
                dangerousSpeed: 89.5,
                drivingTime: 292,
              ));
            },
            text: "create Acceleration Data"),
        TelemeticsButton(
            onPressed: () {
              db.create(TelemeticsDatabaseModel(
                  brakingValue: 5,
                  dangerousBrakeValue: 2,
                  dangerousTurnValue: 3,
                  score: 1));
            },
            text: "create braking Data")
      ]),
    );
  }
}
