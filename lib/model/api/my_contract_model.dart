class MyContractModel {
  final int? contractValue;
  final String? contractId;
  final List? contractData;
  MyContractModel({
    this.contractId,
    this.contractValue,
    this.contractData,
  });
  factory MyContractModel.fromJson(Map<String, dynamic> json) {
    return MyContractModel(
      contractValue: json['contractValue'],
      contractId: json['contractId'],
      contractData: json['contractData'],
    );
  }

  Map<String, dynamic> toJson() => {
        "contractValue": contractValue,
        "contractId": contractId,
        "contractData": contractData,
      };
}
