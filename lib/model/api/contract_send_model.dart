class ContractSendModel {
  final String? companyId;
  final String? userId;
  final String? carId;
  final int? contractValue;
  final String? start;
  final String? expire;
  final String? contractModelType;
  final String? promotionCodeId;
  final List? contractData;
  ContractSendModel({
    required this.companyId,
    required this.userId,
    required this.carId,
    required this.contractValue,
    required this.start,
    required this.expire,
    required this.contractModelType,
    required this.contractData,
    required this.promotionCodeId,
  });
  factory ContractSendModel.fromJson(Map<String, dynamic> json) {
    return ContractSendModel(
      companyId: json['companyId'],
      userId: json['userId'],
      carId: json['carId'],
      contractValue: json['contractValue'],
      start: json['start'],
      expire: json['expire'],
      contractModelType: json['contractModelType'],
      contractData: json['contractData'],
      promotionCodeId: json['promotionCodeId'],
    );
  }

  Map<String, dynamic> toJson() => {
        "companyId": companyId,
        "userId": userId,
        "carId": carId,
        "contractValue": contractValue,
        "start": start,
        "expire": expire,
        "contractModelType": contractModelType,
        "contractData": contractData,
        "promotionCodeId": promotionCodeId,
      };
}
