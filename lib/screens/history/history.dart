import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:web3dart/web3dart.dart';

import '../../constants/i18n/index.dart';
import '../../constants/index.dart';
import '../../logic/index.dart';
import '../../services/index.dart';
import '../../widgets/index.dart';

class History extends StatefulWidget {
  const History({super.key});
  static const String id = 'History';

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late Client httpClient;
  late Web3Client ethClient;
  InteractChainService interactChainService = InteractChainService();
  final address = "0x351f062D06A95FC7e2E8E52923C02D9346B3E8cf";
  final url = "https://indy-chain1.celab.network";
  late List data = [];

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
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    httpClient = Client();
    ethClient = Web3Client(url, httpClient);
    getBalance(address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "history of Safty score",
              style: TextStyle(color: Colors.white),
            ),
            Divider(
              color: Colors.white,
              thickness: 1,
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return HistoryBox(
                    date: data[index][5].toString(),
                    score: data[index][6].toString(),
                    braking: data[index][0].toString(),
                    acceleration: data[index][4].toString(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
