import 'package:flutter/material.dart';

class ResultBox extends StatelessWidget {
  final String brakingValue;
  final String accelerationValue;
  final String deductedScoreValue;
  final String date;
  const ResultBox(
      {super.key,
      required this.date,
      required this.brakingValue,
      required this.accelerationValue,
      required this.deductedScoreValue});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "braking",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              Text(
                brakingValue,
                style: TextStyle(
                    color: Theme.of(context).textTheme.subtitle1?.color),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "acceleration",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              Text(
                accelerationValue,
                style: TextStyle(
                    color: Theme.of(context).textTheme.subtitle1?.color),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "deductedScore",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              Text(
                deductedScoreValue,
                style: TextStyle(
                    color: Theme.of(context).textTheme.subtitle1?.color),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "date",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              Text(
                date,
                style: TextStyle(
                    color: Theme.of(context).textTheme.subtitle1?.color),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
