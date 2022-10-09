const String tablePassCodePwd = 'passCodePwd';

class PassCodePwdFields {
  static final List<String> values = [id, pwdPassCode];

  static const String id = '_id';
  static const String pwdPassCode = 'pwdPassCode';
}

class PassCodePwdDatabaseModel {
  final int? id;
  final String pwdPassCode;

  // constructor
  const PassCodePwdDatabaseModel({
    this.id,
    required this.pwdPassCode,
  });

  PassCodePwdDatabaseModel copy({
    int? id,
    String? loginStatus,
  }) =>
      PassCodePwdDatabaseModel(
        id: id ?? this.id,
        pwdPassCode: loginStatus ?? pwdPassCode,
      );

  static PassCodePwdDatabaseModel fromJson(Map<String, Object?> json) =>
      PassCodePwdDatabaseModel(
        id: json[PassCodePwdFields.id] as int?,
        pwdPassCode: json[PassCodePwdFields.pwdPassCode] as String,
      );

  Map<String, Object?> toJson() => {
        PassCodePwdFields.id: id,
        PassCodePwdFields.pwdPassCode: pwdPassCode,
      };
}
