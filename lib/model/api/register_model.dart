class SignUp {
  final String? name;
  final String? lastName;
  final String? email;
  final String? password;
  final String? gender;
  final String? dateOfBirth;
  final String? confirmPassword;
  final String? macAddress;
  SignUp({
    this.name,
    this.lastName,
    this.email,
    this.password,
    this.gender,
    this.dateOfBirth,
    this.confirmPassword,
    this.macAddress,
  });

  factory SignUp.fromJson(Map<String, dynamic> json) {
    return SignUp(
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      confirmPassword: json['confirmPassword'],
      macAddress: json['macAddress'],
    );
  }
  Map<String, dynamic> toJson() => {
        "name": name,
        "lastName": lastName,
        "email": email,
        "password": password,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "confirmPassword": confirmPassword,
        "macAddress": macAddress,
      };
}
