class SignIn {
  final String? email;
  final String? password;

  SignIn({
    this.email,
    this.password,
  });

  factory SignIn.fromJson(Map<String, dynamic> json) {
    return SignIn(
      email: json['email'],
      password: json['password'],
    );
  }
  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
