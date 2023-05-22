import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:web3dart/web3dart.dart';

import '../../constants/i18n/index.dart';
import '../../constants/index.dart';
import '../../logic/dashboard_cubit/dashboard_cubit_cubit.dart';
import '../../logic/index.dart';
import '../../services/index.dart';
import '../../widgets/history/history_model.dart';
import '../../widgets/index.dart';
import 'model_detail_history.dart';

class ModelHistory extends StatefulWidget {
  const ModelHistory({super.key});
  static const String id = 'ModelHistory';

  @override
  State<ModelHistory> createState() => _ModelHistoryState();
}

class _ModelHistoryState extends State<ModelHistory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Model History of Contract'),
      ),
      body: BlocConsumer<DashboardCubitCubit, DashboardCubitState>(
        listener: (context, state) {
          if (state is HistoryModelCompanyDetailState) {
            Navigator.pushNamed(context, ModelDetailHistory.id).then((value) =>
                {context.read<DashboardCubitCubit>().funcAGetModelCompany()});
          }
        },
        builder: (context, state) {
          if (state is HistoryModelCompanyState) {
            return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.modelList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ModelHistoryBox(
                          companyId:
                              state.modelList[index].companyId.toString(),
                          companyName:
                              state.modelList[index].companyName.toString(),
                        );
                      }),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
