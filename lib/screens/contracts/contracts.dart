import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/dashboard_cubit/dashboard_cubit_cubit.dart';
import '../../model/api/contract_send_model.dart';
import '../../widgets/telemetics/button/button.dart';
import '../model_history/model_history.dart';

class Contract extends StatefulWidget {
  const Contract({super.key});
  static const String id = 'Contract';
  @override
  State<Contract> createState() => _ContractState();
}

class _ContractState extends State<Contract> {
  late final TextEditingController promotion = TextEditingController();
  final Map<String, TextEditingController> _controllerMap = {};
  late Map<dynamic, dynamic> cost = {"name": "no Name", "cost": 0};
  late double text = 0;
  late List textFieldList = [];
  late List controllerList = [];
  late List resultList = [];
  TextEditingController _getControllerOf(String name) {
    var controller = _controllerMap[name];
    if (controller == null) {
      controller = TextEditingController(text: name);
      _controllerMap[name] = controller;
    }
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    print(textFieldList);
    print(controllerList);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contract'),
      ),
      body: BlocConsumer<DashboardCubitCubit, DashboardCubitState>(
        listener: (context, state) {
          if (state is HistoryModelCompanyState) {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
          }
        },
        builder: (context, state) {
          if (state is ContractState) {
            if (state.contract['textfield'] != []) {
              return SingleChildScrollView(
                  child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.contract['textfield'].length,
                        padding: const EdgeInsets.all(5),
                        itemBuilder: (BuildContext context, int index) {
                          textFieldList.add(state.contract['textfield'] != []
                              ? state.contract['textfield'][index]
                              : "empty");
                          final controller = _getControllerOf(
                              state.contract['textfield'][index]);
                          final textField = TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: state.contract['textfield'][index],
                            ),
                          );
                          return Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: textField,
                          );
                        },
                      ),
                      TelemeticsButton(
                        onPressed: () {
                          context
                              .read<DashboardCubitCubit>()
                              .verifyPromotionCode(
                                  promotion.text, state.contract['companyId'])
                              .then((value) {
                            setState(() {
                              for (TextEditingController controllers
                                  in _controllerMap.values) {
                                controllerList.add(controllers.text);
                              }
                              for (var i = 0;
                                  i < state.contract['textfield'].length;
                                  i++) {
                                Map data = {
                                  textFieldList[i]: controllerList[i]
                                };
                                resultList.add(data);
                              }

                              controllerList = [];
                              cost = value;
                              text = (int.parse(state.contract['value']) -
                                  ((int.parse(state.contract['value']) *
                                          cost['cost']) /
                                      100));
                              ContractSendModel data = ContractSendModel(
                                  companyId: state.contract['companyId'],
                                  start: "12/2/2023",
                                  carId: "hj1566",
                                  contractValue: text.toInt(),
                                  expire: "12/8/2023",
                                  contractModelType: "standalone",
                                  userId: state.contract['userID'],
                                  contractData: resultList,
                                  promotionCodeId: promotion.text.isNotEmpty
                                      ? promotion.text
                                      : "no");
                              context.read<DashboardCubitCubit>().sendContract(
                                  data, state.contract['companyId']);
                              resultList = [];
                            });
                          });
                        },
                        text: 'Send Contract',
                      ),
                      TextField(
                        controller: promotion,
                        textCapitalization: TextCapitalization.characters,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "verify promo Code",
                        ),
                      ),
                      TelemeticsButton(
                        onPressed: () {
                          context
                              .read<DashboardCubitCubit>()
                              .verifyPromotionCode(
                                  promotion.text, state.contract['companyId'])
                              .then((value) {
                            setState(() {
                              cost = value;
                            });
                          });
                        },
                        text: 'Check PromoCode',
                      ),
                      Center(
                        child: Container(
                            width: 300,
                            height: 50,
                            color: Colors.greenAccent,
                            child: Column(
                              children: [
                                Text(
                                  " Cost " + cost['cost'].toString(),
                                ),
                                Text(
                                  "Name " + cost['name'].toString(),
                                ),
                                cost['cost'] == 0
                                    ? Text(
                                        "All cost " +
                                            state.contract['value'].toString(),
                                      )
                                    : Text(
                                        "All cost " +
                                            (int.parse(state
                                                        .contract['value']) -
                                                    ((int.parse(state.contract[
                                                                'value']) *
                                                            cost['cost']) /
                                                        100))
                                                .toString(),
                                      ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ));
            } else {
              return Text("Data Empty");
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
