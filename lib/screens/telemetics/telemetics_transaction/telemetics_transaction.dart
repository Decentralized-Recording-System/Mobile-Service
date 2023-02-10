import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../model/index.dart';
import '../../../services/index.dart';
import '../../../utils/private_keys/private_key.dart';
import '../../../widgets/index.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class TelemeticsTransaction extends StatefulWidget {
  const TelemeticsTransaction({super.key});
  static const String id = 'TelemeticsTransaction';
  @override
  State<TelemeticsTransaction> createState() => _TelemeticsTransactionState();
}

class _TelemeticsTransactionState extends State<TelemeticsTransaction> {
  late TelemeticsDatabase db;
  late TelemeticsAccelerationDatabase dbAcc;
  late Future<List<TelemeticsDatabaseModel>> brakingScore;
  late Future<List<TelemeticsAccelerationModel>> accelerationScore;
  late Client httpClient;
  late Web3Client ethClient;
  late Web3Dart web3Function = Web3Dart();
  final url = "https://indy-chain1.celab.network";
  late int resultOfScoreAcceleration = 0;
  late int resultOfScoreBraking = 0;
  @override
  void initState() {
    super.initState();
    db = TelemeticsDatabase.instance;
    dbAcc = TelemeticsAccelerationDatabase.instance;
    WidgetsFlutterBinding.ensureInitialized();
    httpClient = Client();
    ethClient = Web3Client(url, httpClient);
    accelerationScore = dbAcc.readAllData();

    brakingScore = db.readAllData();
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString('assets/abi/abi.json');
    String contractAddress = "0xBca0fDc68d9b21b5bfB16D784389807017B2bbbc";
    final contract = DeployedContract(ContractAbi.fromJson(abi, "DRS_1"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(
        "60990d109319b975595a0cd9b74823aac59b23654ff61bb0322add2eb6f3cf46");

    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract, function: ethFunction, parameters: args),
        chainId: null,
        fetchChainIdFromNetworkId: true);
    return result;
  }

  Future<void> sendData(String targetAddress) async {
    var bigAmount = BigInt.from(10);
    var response = await submit("addData", [
      bigAmount,
      bigAmount,
      bigAmount,
      bigAmount,
      bigAmount.toString(),
      bigAmount.toString(),
      BigInt.from(80)
    ]);
    print(response);
    // return response;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColorLight,
          content: SingleChildScrollView(
            child: Center(
              child: Text(
                  "Uploaded! wait about 1-2 minutes before reading your data"),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Exit',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.subtitle1?.color),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Information')),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Braking Table",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.subtitle1?.color),
                  ),
                  SizedBox(height: 10),
                  FutureBuilder<List<TelemeticsDatabaseModel>>(
                      future: brakingScore,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty) {
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  TelemeticsDatabaseModel braking =
                                      snapshot.data![index];
                                  return TelemeticsHistoryBox(
                                    deductedScore: braking.score.toString(),
                                    date: '7/12/2565',
                                    title: 'Braking',
                                    titleValue: braking.highestValue.toString(),
                                  );
                                });
                          } else {
                            return Container(
                                width: 350,
                                height: 50,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: Center(
                                  child: Text(
                                    "Empty",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.color),
                                  ),
                                ));
                          }
                        } else {
                          return Text("Empty");
                        }
                      }),
                  SizedBox(height: 10),
                  Text(
                    "Acceleration Table",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.subtitle1?.color),
                  ),
                  SizedBox(height: 10),
                  FutureBuilder<List<TelemeticsAccelerationModel>>(
                      future: accelerationScore,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty) {
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  TelemeticsAccelerationModel
                                      accelerationScore = snapshot.data![index];

                                  return TelemeticsHistoryBox(
                                    deductedScore:
                                        accelerationScore.score.toString(),
                                    date: '14/12/2565',
                                    title: 'Acceleration',
                                    titleValue: accelerationScore.highestValue
                                        .toString(),
                                  );
                                });
                          } else {
                            return Container(
                                width: 350,
                                height: 50,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: Center(
                                  child: Text(
                                    "Empty",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.color),
                                  ),
                                ));
                          }
                        } else {
                          return Text("Empty");
                        }
                      }),
                  SizedBox(height: 10),
                  Text(
                    "Result of All Tables",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.subtitle1?.color),
                  ),
                  SizedBox(height: 10),
                  ResultBox(
                      brakingValue: '8',
                      accelerationValue: "2",
                      deductedScoreValue: "4",
                      date: "12/12/2565"),
                  TelemeticsButton(
                    onPressed: () {
                      try {
                        sendData("hfg");
                        _showMyDialog();
                      } catch (e) {
                        print(e.toString());
                      }
                      // web3Function.getPrivateKey();
                      // sendData('0x2c41E9c7A248d955493Ba6D8A26722ee3dB9631f');
                    },
                    text: 'Send Transaction',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
