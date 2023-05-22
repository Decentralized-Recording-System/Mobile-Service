class PromotionModel {
  final int? discount;
  final String? promotionCodeName;

  PromotionModel({
    this.discount,
    this.promotionCodeName,
  });
  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    return PromotionModel(
      discount: json['discount'],
      promotionCodeName: json['promotionCodeName'],
    );
  }

  Map<String, dynamic> toJson() => {
        "discount": discount,
        "promotionCodeName": promotionCodeName,
      };
}
