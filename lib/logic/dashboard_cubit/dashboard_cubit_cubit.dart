import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/api/contract_model.dart';
import '../../model/api/contract_send_model.dart';
import '../../model/api/driving_model.dart';
import '../../model/api/model_data.dart';
import '../../model/api/model_detail_data.dart';
import '../../model/api/my_contract_model.dart';
import '../../model/api/promotion_code.dart';
import '../../model/api/user_model.dart';
import '../../model/share_preferance/signIn_share_preferance.dart';
import '../../repositories/driving_repo.dart';
import '../../repositories/index.dart';
import '../../services/api/driving_api/driving_api.dart';

part 'dashboard_cubit_state.dart';

class DashboardCubitCubit extends Cubit<DashboardCubitState> {
  DashboardCubitCubit({required this.drivingRepository})
      : super(DashboardCubitInitial());
  DrivingRepository drivingRepository = DrivingRepository();
  DrivingService drivingService = DrivingService();

  int braking = 0;
  int dangerousBrake = 0;
  int dangerousTurn = 0;
  int dangerousSpeed = 0;
  double averageSpeed = 0;
  int drivingTime = 0;
  int score = 0;
  double result = 0;
  List textfield = [];
  List myContract = [];
  void funcGetDataDriving() async {
    emit(const DashBoardLoadingState());
    var listDataDriving = await drivingRepository.getDrivingData();
    print(listDataDriving);
    emit(DashBoardDataDrivingState(drivingDataList: listDataDriving));
  }

  void funcGetDataDrivingResult() async {
    int braking = 0;
    int dangerousBrake = 0;
    int dangerousTurn = 0;
    int dangerousSpeed = 0;
    double averageSpeed = 0;
    int drivingTime = 0;
    int score = 0;
    double result = 0;
    emit(const DashBoardLoadingState());
    var listDataDriving = await drivingRepository.getDrivingData();
    print(listDataDriving);
    for (var element in listDataDriving) {
      braking += element.braking!;
      dangerousBrake += element.dangerousBrake!;
      dangerousTurn += element.dangerousTurn!;
      dangerousSpeed += element.dangerousSpeed!;
      averageSpeed += double.parse(element.averageSpeed!);
      drivingTime += element.drivingTime!;
      score += element.score!;
    }
    print(score);
    Map<dynamic, dynamic> data = {
      "braking": braking,
      "dangerousBrake": dangerousBrake,
      "dangerousTurn": dangerousTurn,
      "dangerousSpeed": dangerousSpeed,
      "averageSpeed": averageSpeed,
      "drivingTime": drivingTime,
      "score":
          double.parse((((10000 - score).toDouble()) / 100).toStringAsFixed(1)),
    };
    result = braking.toDouble() +
        dangerousBrake.toDouble() +
        dangerousTurn.toDouble() +
        dangerousSpeed.toDouble();

    late Map<String, double> dataMap = <String, double>{
      "lightGreen": braking.toDouble() * 100 / result,
      "yellow": dangerousBrake.toDouble() * 100 / result,
      "orangeAccent": dangerousTurn.toDouble() * 100 / result,
      "redAccent": dangerousSpeed.toDouble() * 100 / result,
    };

    Map<dynamic, dynamic> allData = {"data": data, "dataMap": dataMap};
    emit(DashBoardDataDrivingResultState(drivingDataList: allData));
  }

  void funcAddDataDriving(Map listData) async {
    print("funcAddDataDriving");
    emit(const DashBoardLoadingState());
    UserSharePreference.getAuth().then((value) {
      var listDataDriving = drivingService.addDrivingData(value!, listData);
    });
  }

  void funcAGetModelCompany() async {
    emit(const DashBoardLoadingState());
    var listDataDriving = await drivingRepository.getModelCompanyData();
    emit(HistoryModelCompanyState(modelList: listDataDriving));
  }

  void funcAGetModelCompanyDetail(String companyId) async {
    emit(const DashBoardLoadingState());
    var listDataDriving =
        await drivingRepository.getModelCompanyDataDetail(companyId);
    emit(HistoryModelCompanyDetailState(modelDetailList: listDataDriving));
  }

  void funcAGetContractData(String modelId) async {
    List textfield = [];
    emit(const DashBoardLoadingState());
    var listDataDriving = await drivingRepository.getModelContractData(modelId);
    print(listDataDriving.data![0]);
    for (var element in listDataDriving.data![0]) {
      textfield.add(element.keys.toString().replaceAll(RegExp(r'[()]'), ''));
      print(element.keys.toString().replaceAll(RegExp(r'[()]'), ''));
    }
    Users userProfile = await drivingRepository.getProfile();

    var data = {
      "companyId": listDataDriving.companyId,
      "textfield": textfield,
      "userID": userProfile.userId,
      "value": listDataDriving.modelContractValue
    };
    print(data);
    emit(ContractState(contract: data));
  }

  void getHistoryState() {
    emit(const HistoryState());
  }

  //!
  void sendContract(ContractSendModel data, companyId) async {
    emit(const DashBoardLoadingState());
    print(data.contractValue);
    print(data.contractData);
    if (data.promotionCodeId!.isEmpty) {
      await drivingRepository.sendContractDataRepo(data);
    } else {
      await drivingRepository.sendContractDataRepo(data);

      // await drivingRepository.useEmail(data.promotionCodeId, companyId);
    }
    funcAGetModelCompany();
  }

  Future<Map<dynamic, dynamic>> verifyPromotionCode(
      promotionCodeId, companyId) async {
    var status =
        await drivingRepository.verifyEmail(promotionCodeId, companyId);
    if (status.promotionCodeName != null) {
      return {"cost": status.discount, "name": status.promotionCodeName};
    }

    return {"cost": 0, "name": "no name"};
  }

  void funcAGetMyContract() async {
    emit(const DashBoardLoadingState());
    var data = await drivingRepository.getMyContract();
    print(data);
    emit(MyContractState(contract: data));
  }

  void funcGetContractDetail(String contractId) async {
    print(1);
    List myContract = [];
    emit(const DashBoardLoadingState());
    var listContract = await drivingRepository.getMyContractDetail(contractId);

    for (var element in listContract.contractData!) {
      myContract.add({
        "a": element.keys.toString().replaceAll(RegExp(r'[()]'), ''),
        "b": element.values.toString().replaceAll(RegExp(r'[()]'), ''),
      });
    }

    print(myContract);
    emit(MyContractDetailState(contractDetail: myContract));
  }
  // void usePromotionCode(promotionCodeId, companyId) async {
  //   emit(const DashBoardLoadingState());

  //   print(status);
  // }
}
