class VerifyEmail {
  final String? email;
  final int? code;

  VerifyEmail({
    this.email,
    this.code,
  });

  factory VerifyEmail.fromJson(Map<String, dynamic> json) {
    return VerifyEmail(
      email: json['email'],
      code: json['code'],
    );
  }
  Map<String, dynamic> toJson() => {
        "email": email,
        "code": code,
      };
}
