import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../../../constants/index.dart';

class InteractChainService {
  late Client httpClient;
  late Web3Client ethClient;
  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString('assets/abi/abi.json');
    String contractAddress = "0x1ADB4e782226cf66FF065FDF2D52B1ee7D831A64";
    final contract = DeployedContract(ContractAbi.fromJson(abi, "DRS_1"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    httpClient = Client();
    ethClient = Web3Client(smartContractUrl, httpClient);
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(
        contract: contract, function: ethFunction, params: args);
    return result;
  }

  Future<void> getBalance(String targetAddress) async {
    var result = await query("getAllAddress", []);
    print(result[0]);
  }
}
