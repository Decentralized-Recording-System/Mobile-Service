class ModelCompany {
  final String? companyId;
  final String? companyName;

  ModelCompany({
    this.companyId,
    this.companyName,
  });
  factory ModelCompany.fromJson(Map<String, dynamic> json) {
    return ModelCompany(
      companyId: json['companyId'],
      companyName: json['companyName'],
    );
  }

  Map<String, dynamic> toJson() => {
        "companyId": companyId,
        "companyName": companyName,
      };
}
