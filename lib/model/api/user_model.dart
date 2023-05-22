class Users {
  final String? Name;
  final String? LastName;
  final String? email;
  final String? gender;
  final String? dateOfBirth;
  final String? userId;
  Users(
      {this.Name,
      this.LastName,
      this.email,
      this.gender,
      this.dateOfBirth,
      this.userId});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      Name: json['Name'],
      LastName: json['LastName'],
      email: json['email'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      userId: json['userId'],
    );
  }
}
