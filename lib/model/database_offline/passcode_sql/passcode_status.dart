const String tableLoginStatus = 'loginStatus';

class LoginStatusFields {
  static final List<String> values = [id, loginStatus];

  static const String id = '_id';
  static const String loginStatus = 'loginStatus';
}

class LoginStatusDatabaseModel {
  final int? id;
  final String loginStatus;

  // constructor
  const LoginStatusDatabaseModel({
    this.id,
    required this.loginStatus,
  });

  LoginStatusDatabaseModel copy({
    int? id,
    String? loginStatus,
  }) =>
      LoginStatusDatabaseModel(
        id: id ?? this.id,
        loginStatus: loginStatus ?? this.loginStatus,
      );

  static LoginStatusDatabaseModel fromJson(Map<String, Object?> json) =>
      LoginStatusDatabaseModel(
        id: json[LoginStatusFields.id] as int?,
        loginStatus: json[LoginStatusFields.loginStatus] as String,
      );

  Map<String, Object?> toJson() => {
        LoginStatusFields.id: id,
        LoginStatusFields.loginStatus: loginStatus,
      };
}
