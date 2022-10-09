const String tableTelemetics = 'telemetics';

class TelemeticsFields {
  static final List<String> values = [id, score, highestValue, lowestValue];

  static const String id = '_id';
  static const String score = 'score';
  static const String highestValue = 'highestValue';
  static const String lowestValue = 'lowestValue';
}

class TelemeticsDatabaseModel {
  final int? id;
  final int score;
  final double highestValue;
  final double lowestValue;

  // constructor
  const TelemeticsDatabaseModel({
    this.id,
    required this.score,
    required this.highestValue,
    required this.lowestValue,
  });

  TelemeticsDatabaseModel copy({
    int? id,
    int? score,
    double? highestValue,
    double? lowestValue,
  }) =>
      TelemeticsDatabaseModel(
        id: id ?? this.id,
        score: score ?? this.score,
        highestValue: highestValue ?? this.highestValue,
        lowestValue: lowestValue ?? this.lowestValue,
      );

  static TelemeticsDatabaseModel fromJson(Map<String, Object?> json) =>
      TelemeticsDatabaseModel(
        id: json[TelemeticsFields.id] as int?,
        score: json[TelemeticsFields.score] as int,
        highestValue:
            double.parse(json[TelemeticsFields.highestValue] as String),
        lowestValue: double.parse(json[TelemeticsFields.lowestValue] as String),
      );

  Map<String, Object?> toJson() => {
        TelemeticsFields.id: id,
        TelemeticsFields.score: score,
        TelemeticsFields.highestValue: highestValue,
        TelemeticsFields.lowestValue: lowestValue,
      };
}
