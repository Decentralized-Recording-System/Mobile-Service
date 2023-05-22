class Driving {
  final int? braking;
  final int? dangerousBrake;
  final int? dangerousTurn;
  final int? dangerousSpeed;
  final String? averageSpeed;
  final int? drivingTime;
  final String? date;
  final int? score;
  Driving({
    this.drivingTime,
    this.date,
    this.score,
    this.braking,
    this.dangerousBrake,
    this.dangerousTurn,
    this.dangerousSpeed,
    required this.averageSpeed,
  });
  factory Driving.fromJson(Map<String, dynamic> json) {
    return Driving(
      braking: json['braking'],
      dangerousBrake: json['dangerousBrake'],
      dangerousTurn: json['dangerousTurn'],
      dangerousSpeed: json['dangerousSpeed'],
      averageSpeed: json['averageSpeed'],
      drivingTime: json['drivingTime'],
      date: json['date'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() => {
        "braking": braking,
        "dangerousBrake": dangerousBrake,
        "dangerousTurn": dangerousTurn,
        "dangerousSpeed": dangerousSpeed,
        "averageSpeed": averageSpeed,
        "drivingTime": drivingTime,
        "date": date,
        "score": score,
      };
}
