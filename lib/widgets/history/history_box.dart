import 'package:flutter/material.dart';

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
            color: Colors.white,
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
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      child: const Icon(
                        Icons.calendar_month,
                        color: Color.fromARGB(255, 39, 179, 111),
                      ),
                    )),
                Expanded(
                    flex: 6,
                    child: Row(
                      children: [
                        Text(
                          date,
                          style: TextStyle(
                            color: Colors.grey,
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
                        Text("view detail",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 39, 179, 111),
                            )),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromARGB(255, 39, 179, 111),
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
