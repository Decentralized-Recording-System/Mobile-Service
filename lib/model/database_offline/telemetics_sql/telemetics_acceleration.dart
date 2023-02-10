const String tableTelemeticsAcceleration = 'telemeticsAcceleration';

class TelemeticsAccelerationFields {
  static final List<String> values = [id, score, highestValue];

  static const String id = '_id';
  static const String score = 'score';
  static const String highestValue = 'highestValue';
  static const String lowestValue = 'lowestValue';
}

class TelemeticsAccelerationModel {
  final int? id;
  final int score;
  final double highestValue;

  // constructor
  const TelemeticsAccelerationModel({
    this.id,
    required this.score,
    required this.highestValue,
  });

  TelemeticsAccelerationModel copy({
    int? id,
    int? score,
    double? highestValue,
  }) =>
      TelemeticsAccelerationModel(
        id: id ?? this.id,
        score: score ?? this.score,
        highestValue: highestValue ?? this.highestValue,
      );

  static TelemeticsAccelerationModel fromJson(Map<String, Object?> json) =>
      TelemeticsAccelerationModel(
        id: json[TelemeticsAccelerationFields.id] as int?,
        score: json[TelemeticsAccelerationFields.score] as int,
        highestValue: double.parse(
            json[TelemeticsAccelerationFields.highestValue] as String),
      );

  Map<String, Object?> toJson() => {
        TelemeticsAccelerationFields.id: id,
        TelemeticsAccelerationFields.score: score,
        TelemeticsAccelerationFields.highestValue: highestValue,
      };
}
