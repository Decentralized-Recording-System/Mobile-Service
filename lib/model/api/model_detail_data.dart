class ModelCompanyDetail {
  final String? modelContractId;
  final String? modelContractName;

  ModelCompanyDetail({
    this.modelContractId,
    this.modelContractName,
  });
  factory ModelCompanyDetail.fromJson(Map<String, dynamic> json) {
    return ModelCompanyDetail(
      modelContractId: json['modelContractId'],
      modelContractName: json['modelContractName'],
    );
  }

  Map<String, dynamic> toJson() => {
        "modelContractId": modelContractId,
        "modelContractName": modelContractName,
      };
}
