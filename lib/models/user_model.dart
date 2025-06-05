import 'package:app_economize_mais/models/address_model.dart';

class UserModel {
  final String? id;
  final String email;
  final String fullName;
  final String userType;
  final String? birthDate;
  final List<AddressModel> addresses;
  final String gender;
  final String? companyName;
  final String? tradeName;
  final String? logoUrl;

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        fullName = json['fullName'],
        userType = json['userType'],
        birthDate = json['birthDate'],
        addresses = List.from((json['addresses'] as List? ?? [])
            .map((e) => AddressModel.fromJson(e))),
        gender = json['gender'],
        companyName = json['companyName'],
        tradeName = json['tradeName'],
        logoUrl = json['logoUrl'];
}
