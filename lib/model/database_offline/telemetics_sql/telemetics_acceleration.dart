const String tableTelemeticsAcceleration = 'telemeticsAcceleration';

class TelemeticsAccelerationFields {
  static final List<String> values = [
    id,
    score,
    dangerousSpeed,
    averageSpeed,
    drivingTime
  ];

  static const String id = '_id';
  static const String score = 'score';
  static const String dangerousSpeed = 'dangerousSpeed';
  static const String averageSpeed = 'averageSpeed';
  static const String drivingTime = 'drivingTime';
}

class TelemeticsAccelerationModel {
  final int? id;
  final int score;
  final double dangerousSpeed;
  final double averageSpeed;
  final double drivingTime;

  // constructor
  const TelemeticsAccelerationModel({
    this.id,
    required this.score,
    required this.dangerousSpeed,
    required this.averageSpeed,
    required this.drivingTime,
  });

  TelemeticsAccelerationModel copy({
    int? id,
    int? score,
    double? dangerousSpeed,
    double? averageSpeed,
    double? drivingTime,
  }) =>
      TelemeticsAccelerationModel(
        id: id ?? this.id,
        score: score ?? this.score,
        dangerousSpeed: dangerousSpeed ?? this.dangerousSpeed,
        averageSpeed: averageSpeed ?? this.averageSpeed,
        drivingTime: drivingTime ?? this.drivingTime,
      );

  static TelemeticsAccelerationModel fromJson(Map<String, Object?> json) =>
      TelemeticsAccelerationModel(
        id: json[TelemeticsAccelerationFields.id] as int?,
        score: json[TelemeticsAccelerationFields.score] as int,
        dangerousSpeed: double.parse(
            json[TelemeticsAccelerationFields.dangerousSpeed] as String),
        averageSpeed: double.parse(
            json[TelemeticsAccelerationFields.averageSpeed] as String),
        drivingTime: double.parse(
            json[TelemeticsAccelerationFields.drivingTime] as String),
      );

  Map<String, Object?> toJson() => {
        TelemeticsAccelerationFields.id: id,
        TelemeticsAccelerationFields.score: score,
        TelemeticsAccelerationFields.dangerousSpeed: dangerousSpeed,
        TelemeticsAccelerationFields.averageSpeed: averageSpeed,
        TelemeticsAccelerationFields.drivingTime: drivingTime,
      };
}
