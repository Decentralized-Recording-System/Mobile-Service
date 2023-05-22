import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:telemetics/screens/my_contract/mycontract.dart';
import 'package:web3dart/web3dart.dart';

import '../../constants/i18n/index.dart';
import '../../constants/index.dart';
import '../../logic/dashboard_cubit/dashboard_cubit_cubit.dart';
import '../../logic/index.dart';
import '../../services/index.dart';
import '../../widgets/history/contract_box.dart';
import '../../widgets/history/my_contract_box.dart';
import '../../widgets/index.dart';
import '../contracts/contracts.dart';

class MyContract extends StatefulWidget {
  const MyContract({super.key});
  static const String id = 'MyContract';

  @override
  State<MyContract> createState() => _MyContractState();
}

class _MyContractState extends State<MyContract> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyContract'),
      ),
      body: BlocConsumer<DashboardCubitCubit, DashboardCubitState>(
        listener: (context, state) {
          if (state is MyContractDetailState) {
            Navigator.pushNamed(context, MyDetailContract.id).then((value) =>
                {context.read<DashboardCubitCubit>().funcAGetMyContract()});
          }
        },
        builder: (context, state) {
          if (state is MyContractState) {
            return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.contract.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MyContractBox(
                          modelContractId:
                              state.contract[index].contractId.toString(),
                          modelContractName:
                              state.contract[index].contractValue.toString(),
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
