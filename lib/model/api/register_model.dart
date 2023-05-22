class SignUp {
  final String? name;
  final String? lastName;
  final String? email;
  final String? password;
  final String? gender;
  final String? dateOfBirth;
  final String? confirmPassword;
  final String? macAddress;
  final String? carModel;
  final String? carLicenseNo;
  final String? carChassisNo;
  final int? carModelYr;
  final String? carBodyType;
  final int? carNoOfSeats;
  final int? carDisplacement;
  final int? carGVM;
  SignUp({
    this.carModel,
    this.carLicenseNo,
    this.carChassisNo,
    this.carModelYr,
    this.carBodyType,
    this.carNoOfSeats,
    this.carDisplacement,
    this.carGVM,
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
      carModel: json['carModel'],
      carLicenseNo: json['carLicenseNo'],
      carChassisNo: json['carChassisNo'],
      carModelYr: json['carModelYr'],
      carBodyType: json['carBodyType'],
      carNoOfSeats: json['carNoOfSeats'],
      carDisplacement: json['carDisplacement'],
      carGVM: json['carGVM'],
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
        "carModel": carModel,
        "carLicenseNo": carLicenseNo,
        "carChassisNo": carChassisNo,
        "carModelYr": carModelYr,
        "carBodyType": carBodyType,
        "carNoOfSeats": carNoOfSeats,
        "carDisplacement": carDisplacement,
        "carGVM": carGVM,
      };
}
