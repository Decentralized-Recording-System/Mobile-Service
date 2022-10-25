import 'package:flutter/material.dart';

import '../../constants/i18n/app_localizations.dart';

class HistoryBox extends StatelessWidget {
  const HistoryBox(
      {super.key,
      required this.historyStatus,
      required this.date,
      required this.score});
  final String historyStatus;
  final String date;
  final String score;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.75),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      child: Icon(
                        Icons.calendar_month,
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    )),
                Expanded(
                    flex: 6,
                    child: Row(
                      children: [
                        Text(
                          date,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline2!.color,
                          ),
                        )
                      ],
                    )),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      print(date);
                    },
                    child: Row(
                      children: [
                        Text(AppLocalizations.of(context)!.translate('Detail'),
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorDark,
                            )),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryColor,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
