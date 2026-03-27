
class UserModel {
  int id;
  String firstName;
  String lastName;
  String email;
  String profile;
  String gender;
  String dob;
  String address;
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profile,
    required this.gender,
    required this.dob,
    required this.address,
  });



  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      firstName: map['firstName'] ?? "fn",
      lastName: map['lastName'] ?? "ln",
      email: map['email'] ?? "email",
      profile: map['profile'] ?? "pf",
      gender: map['gender'] ?? "gender",
      dob: map['dob'] ?? "dob",
      address: map['address'] ?? "address",
    );
  }

  
}
