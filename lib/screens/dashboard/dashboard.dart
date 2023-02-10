import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:telemetics/constants/variable/smart_contract/smart_contract.dart';
import 'package:web3dart/web3dart.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../constants/i18n/index.dart';
import '../../services/index.dart';
import '../../widgets/index.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static const String id = 'Dashboard';
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Client httpClient;
  late Web3Client ethClient;
  InteractChainService interactChainService = InteractChainService();
  final address = "0x351f062D06A95FC7e2E8E52923C02D9346B3E8cf";
  final url = "https://indy-chain1.celab.network";
  List data = [];
  late int braking = 0;
  late int acceleration = 0;
  late Map<String, double> dataMap = <String, double>{
    "Green": 5,
    "Yellow": 5,
  };

  final colorList = <Color>[
    Colors.greenAccent,
    Colors.yellow,
  ];
  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString('assets/abi/abi.json');
    String contractAddress = "0xBca0fDc68d9b21b5bfB16D784389807017B2bbbc";
    final contract = DeployedContract(ContractAbi.fromJson(abi, "DRS_1"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(
        contract: contract, function: ethFunction, params: args);
    return result;
  }

  Future<void> getBalance(String targetAddress) async {
    // EthereumAddress address = EthereumAddress.fromHex(targetAddress);
    var result = await query("getAllData", []);
    data = result[0][1][1];

    var countBraking = 0;
    var countAcceleartion = 0;
    for (var i = 0; i < data.length; i++) {
      countBraking += int.parse(data[i][0].toString());
      countAcceleartion += int.parse(data[i][4].toString());
    }
    braking = countBraking;
    acceleration = countAcceleartion;
    print(data[data.length - 1][6]);
    dataMap = <String, double>{
      "Green": braking.toDouble() *
          10 /
          (braking.toDouble() + acceleration.toDouble()),
      "Yellow": acceleration.toDouble() *
          10 /
          (braking.toDouble() + acceleration.toDouble()),
    };
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    getBalance(address);

    httpClient = Client();
    ethClient = Web3Client(url, httpClient);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                color: Theme.of(context).appBarTheme.backgroundColor,
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 12,
                          child: Container(
                            color: Theme.of(context).primaryColorDark,
                            child: Column(children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    color: Theme.of(context).primaryColorDark,
                                  )),
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Container(
                                            child: PieChart(
                                              initialAngleInDegree: 0,
                                              dataMap: dataMap,
                                              chartType: ChartType.disc,
                                              baseChartColor: Colors.grey[300]!,
                                              colorList: colorList,
                                              legendOptions: LegendOptions(
                                                showLegendsInRow: false,
                                                legendPosition:
                                                    LegendPosition.right,
                                                showLegends: false,
                                                legendShape: BoxShape.circle,
                                                legendTextStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              chartValuesOptions:
                                                  ChartValuesOptions(
                                                showChartValuesInPercentage:
                                                    false,
                                                showChartValueBackground: false,
                                                showChartValues: false,
                                                showChartValuesOutside: false,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "braking",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "${(braking.toDouble() * 10 / (braking.toDouble() + acceleration.toDouble())).toStringAsFixed(2)} %",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1
                                                            ?.color),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "acceleration",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "${(acceleration.toDouble() * 10 / (braking.toDouble() + acceleration.toDouble())).toStringAsFixed(2)} %",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1
                                                            ?.color),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Text("Safety Levels",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor)))
                            ]),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          )),
                      Expanded(
                          flex: 6,
                          child: Container(
                            color: Theme.of(context).primaryColorDark,
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "event distribution",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 1.4,
                                          ),
                                          Expanded(
                                              child: Divider(
                                            color: Colors.white,
                                            thickness: 0.4,
                                          ))
                                        ],
                                      ),
                                    )),
                                Expanded(
                                    flex: 7,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 25, horizontal: 50),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "braking",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                Text(
                                                  braking.toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1
                                                          ?.color),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "acceleration",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                Text(
                                                  acceleration.toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .subtitle1
                                                          ?.color),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.width * 0.6,
          top: MediaQuery.of(context).size.height * 0.15,
          left: MediaQuery.of(context).size.width * 0.2,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.circle),
            child: CircularPercentIndicator(
              radius: 110.0,
              lineWidth: 15.0,
              percent: 0.7,
              center: data.isNotEmpty
                  ? Text(
                      "${data[data.length - 1][6]} ${AppLocalizations.of(context)!.translate('Point')}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColor),
                    )
                  : const Text("0"),
              backgroundColor: Theme.of(context).primaryColorLight,
              progressColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    ));
  }
}
