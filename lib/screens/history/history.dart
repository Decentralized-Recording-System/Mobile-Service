import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/i18n/index.dart';
import '../../constants/index.dart';
import '../../logic/index.dart';
import '../../widgets/index.dart';

class History extends StatefulWidget {
  const History({super.key});
  static const String id = 'History';
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<SettingCubitCubit>().state;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Container(height: 200, color: Theme.of(context).primaryColor),
            ListView.builder(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: historyStatusScore.length,
                itemBuilder: (BuildContext context, int index) {
                  return HistoryBox(
                    historyStatus: historyStatusScore[index],
                    date: historyDate[index],
                    score: historyScore[index],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
