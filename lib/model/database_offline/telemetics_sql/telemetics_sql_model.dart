const String tableTelemetics = 'telemetics';

class TelemeticsFields {
  static final List<String> values = [
    id,
    score,
    brakingValue,
    dangerousBrakeValue,
    dangerousTurnValue
  ];

  static const String id = '_id';
  static const String score = 'score';
  static const String brakingValue = 'braking';
  static const String dangerousBrakeValue = 'dangerousBrake';
  static const String dangerousTurnValue = 'dangerousTurn';
}

class TelemeticsDatabaseModel {
  final int? id;
  final int score;
  final double brakingValue;
  final double dangerousBrakeValue;
  final double dangerousTurnValue;

  // constructor
  const TelemeticsDatabaseModel({
    this.id,
    required this.score,
    required this.brakingValue,
    required this.dangerousBrakeValue,
    required this.dangerousTurnValue,
  });

  TelemeticsDatabaseModel copy({
    int? id,
    int? score,
    double? brakingValue,
    double? dangerousBrakeValue,
    double? dangerousTurnValue,
  }) =>
      TelemeticsDatabaseModel(
        id: id ?? this.id,
        score: score ?? this.score,
        brakingValue: brakingValue ?? this.brakingValue,
        dangerousBrakeValue: dangerousBrakeValue ?? this.dangerousBrakeValue,
        dangerousTurnValue: dangerousTurnValue ?? this.dangerousTurnValue,
      );

  static TelemeticsDatabaseModel fromJson(Map<String, Object?> json) =>
      TelemeticsDatabaseModel(
        id: json[TelemeticsFields.id] as int?,
        score: json[TelemeticsFields.score] as int,
        brakingValue:
            double.parse(json[TelemeticsFields.brakingValue] as String),
        dangerousBrakeValue:
            double.parse(json[TelemeticsFields.dangerousBrakeValue] as String),
        dangerousTurnValue:
            double.parse(json[TelemeticsFields.dangerousTurnValue] as String),
      );

  Map<String, Object?> toJson() => {
        TelemeticsFields.id: id,
        TelemeticsFields.score: score,
        TelemeticsFields.brakingValue: brakingValue,
        TelemeticsFields.dangerousBrakeValue: dangerousBrakeValue,
        TelemeticsFields.dangerousTurnValue: dangerousTurnValue,
      };
}
