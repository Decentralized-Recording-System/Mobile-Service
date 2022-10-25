const String tableTelemeticsTest = 'telemeticsTest';

class TelemeticsTestFields {
  static final List<String> values = [id, list];

  static const String id = '_id';
  static const String list = 'list';
}

class TelemeticsTestDatabaseModel {
  final int? id;
  final String list;

  // constructor
  const TelemeticsTestDatabaseModel({
    this.id,
    required this.list,
  });

  TelemeticsTestDatabaseModel copy({
    int? id,
    String? list,
  }) =>
      TelemeticsTestDatabaseModel(
        id: id ?? this.id,
        list: list ?? this.list,
      );

  static TelemeticsTestDatabaseModel fromJson(Map<String, Object?> json) =>
      TelemeticsTestDatabaseModel(
        id: json[TelemeticsTestFields.id] as int?,
        list: json[TelemeticsTestFields.list] as String,
      );

  Map<String, Object?> toJson() => {
        TelemeticsTestFields.id: id,
        TelemeticsTestFields.list: list,
      };
}
