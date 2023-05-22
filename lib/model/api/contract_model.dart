class ContractModel {
  final String? modelContractName;
  final List? data;
  final String? companyId;
  final String? modelContractValue;

  ContractModel({
    this.companyId,
    this.modelContractName,
    this.data,
    this.modelContractValue,
  });
  factory ContractModel.fromJson(Map<String, dynamic> json) {
    return ContractModel(
      modelContractName: json['modelContractName'],
      data: json['data'],
      companyId: json['companyId'],
      modelContractValue: json['modelContractValue'],
    );
  }

  Map<String, dynamic> toJson() => {
        "modelContractName": modelContractName,
        "data": data,
        "companyId": companyId,
        "modelContractValue": modelContractValue,
      };
}
