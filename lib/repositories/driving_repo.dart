import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/api/contract_model.dart';
import '../model/api/contract_send_model.dart';
import '../model/api/driving_model.dart';
import '../model/api/model_data.dart';
import '../model/api/model_detail_data.dart';
import '../model/api/my_contract_model.dart';
import '../model/api/promotion_code.dart';
import '../model/api/user_model.dart';
import '../model/share_preferance/signIn_share_preferance.dart';
import '../services/api/driving_api/driving_api.dart';
import '../services/api/index.dart';
import '../services/api/login_api/login_api.dart';

class DrivingRepository {
  DrivingService drivingService = DrivingService();
  LoginService loginService = LoginService();
  UserService userService = UserService();
  late String accessToken = "";
  late Users userProfile;
  Future<List<Driving>> getDrivingData() async {
    await UserSharePreference.getAuth().then((value) {
      accessToken = value!;
    });

    if (accessToken.isNotEmpty) {
      List<Driving> drivingCar =
          await drivingService.getDrivingData(accessToken);

      return drivingCar;
    }

    return [];
  }

  Future<List<ModelCompany>> getModelCompanyData() async {
    await UserSharePreference.getAuth().then((value) {
      accessToken = value!;
    });

    if (accessToken.isNotEmpty) {
      List<ModelCompany> modelCompanyList =
          await drivingService.getModelCompanyData(accessToken);

      return modelCompanyList;
    }

    return [];
  }

  Future<List<ModelCompanyDetail>> getModelCompanyDataDetail(
      String companyId) async {
    await UserSharePreference.getAuth().then((value) {
      accessToken = value!;
    });

    if (accessToken.isNotEmpty) {
      List<ModelCompanyDetail> modelCompanyList = await drivingService
          .getModelCompanyDetailData(accessToken, companyId);

      return modelCompanyList;
    }

    return [];
  }

  Future<ContractModel> getModelContractData(String modelId) async {
    await UserSharePreference.getAuth().then((value) {
      accessToken = value!;
    });

    if (accessToken.isNotEmpty) {
      ContractModel modelCompanyList =
          await drivingService.getModelContractData(accessToken, modelId);

      return modelCompanyList;
    }

    return ContractModel.fromJson({});
  }

  Future<bool> sendContractDataRepo(ContractSendModel data) async {
    await UserSharePreference.getAuth().then((value) {
      accessToken = value!;
    });

    if (accessToken.isNotEmpty) {
      bool modelCompanyList =
          await drivingService.sendContractData(accessToken, data);

      return modelCompanyList;
    }

    return false;
  }

  Future<Users> getProfile() async {
    await UserSharePreference.getAuth().then((value) {
      accessToken = value!;
    });
    if (accessToken.isNotEmpty) {
      userProfile = await userService.getProfile(accessToken);
      return userProfile;
    }
    return Users.fromJson({});
  }

  Future<PromotionModel> verifyEmail(promotionCodeId, companyId) async {
    await UserSharePreference.getAuth().then((value) {
      accessToken = value!;
    });

    if (accessToken.isNotEmpty) {
      PromotionModel modelCompanyList = await drivingService.verifyEmail(
          accessToken, promotionCodeId, companyId);
      print(modelCompanyList.promotionCodeName);
      return modelCompanyList;
    }

    return PromotionModel.fromJson({});
  }

  Future<bool> useEmail(promotionCodeId, companyId) async {
    await UserSharePreference.getAuth().then((value) {
      accessToken = value!;
    });

    if (accessToken.isNotEmpty) {
      bool modelCompanyList = await drivingService.useEmail(
          accessToken, promotionCodeId, companyId);

      return modelCompanyList;
    }

    return false;
  }

  Future<List<MyContractModel>> getMyContract() async {
    await UserSharePreference.getAuth().then((value) {
      accessToken = value!;
    });

    if (accessToken.isNotEmpty) {
      List<MyContractModel> modelCompanyList =
          await drivingService.getMyContractData(accessToken);

      return modelCompanyList;
    }

    return [];
  }

  Future<MyContractModel> getMyContractDetail(String contractId) async {
    await UserSharePreference.getAuth().then((value) {
      accessToken = value!;
    });

    if (accessToken.isNotEmpty) {
      MyContractModel modelCompanyList =
          await drivingService.getMyContractDetail(accessToken, contractId);

      return modelCompanyList;
    }

    return MyContractModel.fromJson({});
  }
}
