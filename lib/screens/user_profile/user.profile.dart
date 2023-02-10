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
              dbAcc.create(
                  TelemeticsAccelerationModel(score: 1, highestValue: 1));
            },
            text: "create Acceleration Data"),
        TelemeticsButton(
            onPressed: () {
              db.create(TelemeticsDatabaseModel(
                  score: 1, highestValue: 5, lowestValue: 0));
            },
            text: "create braking Data")
      ]),
    );
  }
}
