import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressModel {
  String name;
  String gender;
  String phone;
  String address;
  String? detail;
  String? photo;
  AddressModel({
    required this.name,
    required this.gender,
    required this.phone,
    required this.address,
    this.detail,
    this.photo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'gender': gender,
      'phone': phone,
      'address': address,
      'detail': detail,
      'photo': photo,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      name: map['name'] as String,
      gender: map['gender'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      detail: map['detail'] != null ? map['detail'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
