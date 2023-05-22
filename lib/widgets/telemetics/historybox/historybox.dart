import 'package:flutter/material.dart';

class TelemeticsHistoryBox extends StatelessWidget {
  final String title;
  final String titleValue;
  final String deductedScore;
  final String date;
  const TelemeticsHistoryBox(
      {super.key,
      required this.title,
      required this.titleValue,
      required this.deductedScore,
      required this.date});

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
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              Text(
                titleValue,
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
                deductedScore,
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
