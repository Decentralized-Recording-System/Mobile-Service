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
import '../../widgets/history/contract_box.dart';
import '../../widgets/index.dart';
import '../contracts/contracts.dart';

class ModelDetailHistory extends StatefulWidget {
  const ModelDetailHistory({super.key});
  static const String id = 'ModelDetailHistory';

  @override
  State<ModelDetailHistory> createState() => _ModelDetailHistoryState();
}

class _ModelDetailHistoryState extends State<ModelDetailHistory> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ModelDetailHistory of Contract'),
      ),
      body: BlocConsumer<DashboardCubitCubit, DashboardCubitState>(
        listener: (context, state) {
          if (state is ContractState) {
            Navigator.pushNamed(context, Contract.id).then((value) =>
                {context.read<DashboardCubitCubit>().funcAGetModelCompany()});
          }
        },
        builder: (context, state) {
          if (state is HistoryModelCompanyDetailState) {
            return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.modelDetailList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ContractBox(
                          modelContractId: state
                              .modelDetailList[index].modelContractId
                              .toString(),
                          modelContractName: state
                              .modelDetailList[index].modelContractName
                              .toString(),
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
