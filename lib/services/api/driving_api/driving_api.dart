import 'dart:convert';

import '../../../model/api/contract_model.dart';
import '../../../model/api/contract_send_model.dart';
import '../../../model/api/driving_model.dart';
import '../../../model/api/model_data.dart';
import '../../../model/api/model_detail_data.dart';
import '../../../model/api/my_contract_model.dart';
import '../../../model/api/promotion_code.dart';
import '../../network_helper/network_helper.dart';

class DrivingService {
  List<Driving> objectList = [];
  List<ModelCompany> objectModelList = [];
  List<ModelCompanyDetail> objectModelDetailList = [];
  List<MyContractModel> objectMyContractList = [];
  Future<List<Driving>> getDrivingData(String accessToken) async {
    NetworkHelper networkHelper = NetworkHelper();
    final objectJsonDecode =
        await networkHelper.getDataAPIWithHeader('driving-data', accessToken);

    objectList = [];
    for (var element in objectJsonDecode['data']) {
      objectList.add(Driving.fromJson(element));
    }
    print(objectList);
    // Users resources = Users.fromJson(objectJsonDecode);
    return objectList;
  }

  Future<List<ModelCompany>> getModelCompanyData(String accessToken) async {
    try {
      NetworkHelper networkHelper = NetworkHelper();
      final objectJsonDecode = await networkHelper.getDataAPIWithHeaderNoUser(
          'model-contract/user/company', accessToken);

      print(objectJsonDecode['data']);
      objectModelList = [];
      for (var element in objectJsonDecode['data']) {
        objectModelList.add(ModelCompany.fromJson(element));
      }
      // Users resources = Users.fromJson(objectJsonDecode);
      return objectModelList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<ModelCompanyDetail>> getModelCompanyDetailData(
      String accessToken, String companyId) async {
    try {
      NetworkHelper networkHelper = NetworkHelper();
      final objectJsonDecode = await networkHelper.getDataAPIWithHeaderNoUser(
          'model-contract/user/company/$companyId', accessToken);
      print(objectJsonDecode['data']);
      objectModelDetailList = [];
      for (var element in objectJsonDecode['data']) {
        objectModelDetailList.add(ModelCompanyDetail.fromJson(element));
      }
      // Users resources = Users.fromJson(objectJsonDecode);
      return objectModelDetailList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<ContractModel> getModelContractData(
      String accessToken, String modelId) async {
    try {
      NetworkHelper networkHelper = NetworkHelper();
      final objectJsonDecode = await networkHelper.getDataAPIWithHeaderNoUser(
          'model-contract/user/$modelId', accessToken);

      // Users resources = Users.fromJson(objectJsonDecode);
      print(objectJsonDecode['data']);
      return ContractModel.fromJson(objectJsonDecode['data']);
    } catch (e) {
      print(e.toString());
      return ContractModel.fromJson({});
    }
  }

  Future<bool> addDrivingData(String accessToken, Map listData) async {
    try {
      var params = jsonEncode(listData);
      NetworkHelper networkHelper = NetworkHelper();
      final objectJsonDecode = await networkHelper.postDataAPIwithAccessToken(
          'driving-data', params, accessToken);
      print(objectJsonDecode);
      // Users resources = Users.fromJson(objectJsonDecode);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> sendContractData(
      String accessToken, ContractSendModel listData) async {
    try {
      var params = jsonEncode(listData);
      print(params);
      NetworkHelper networkHelper = NetworkHelper();
      final objectJsonDecode =
          await networkHelper.postDataAPIwithAccessTokenWithOutUser(
              'contract/user/create', params, accessToken);
      print(objectJsonDecode);
      // Users resources = Users.fromJson(objectJsonDecode);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<PromotionModel> verifyEmail(
      String accessToken, String promotionCodeId, String companyId) async {
    try {
      var params = jsonEncode(
          {"promotionCodeId": promotionCodeId, "companyId": companyId});

      NetworkHelper networkHelper = NetworkHelper();
      final objectJsonDecode =
          await networkHelper.postDataAPIwithAccessTokenWithOutUser(
              'promotion-code/validate', params, accessToken);

      return PromotionModel.fromJson(objectJsonDecode['data']);
    } catch (e) {
      print(e.toString());
      return PromotionModel.fromJson({});
    }
  }

  Future<bool> useEmail(
      String accessToken, String promotionCodeId, String companyId) async {
    try {
      var params =
          jsonEncode({promotionCodeId: promotionCodeId, companyId: companyId});
      NetworkHelper networkHelper = NetworkHelper();
      final objectJsonDecode =
          await networkHelper.postDataAPIwithAccessTokenWithOutUser(
              'promotion-code/use', params, accessToken);
      print(objectJsonDecode);
      // Users resources = Users.fromJson(objectJsonDecode);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<List<MyContractModel>> getMyContractData(String accessToken) async {
    try {
      NetworkHelper networkHelper = NetworkHelper();
      final objectJsonDecode = await networkHelper.getDataAPIWithHeaderNoUser(
          'contract/user', accessToken);
      objectMyContractList = [];
      for (var element in objectJsonDecode['data']) {
        objectMyContractList.add(MyContractModel.fromJson(element));
      }
      // Users resources = Users.fromJson(objectJsonDecode);
      print(objectJsonDecode['data']);
      return objectMyContractList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<MyContractModel> getMyContractDetail(
      String accessToken, String contractId) async {
    try {
      NetworkHelper networkHelper = NetworkHelper();
      final objectJsonDecode = await networkHelper.getDataAPIWithHeaderNoUser(
          'contract/user/$contractId', accessToken);

      // Users resources = Users.fromJson(objectJsonDecode);
      print(objectJsonDecode['data']);
      return MyContractModel.fromJson(objectJsonDecode['data']);
    } catch (e) {
      print(e.toString());
      return MyContractModel.fromJson({});
    }
  }
}
