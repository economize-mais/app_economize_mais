import 'package:app_economize_mais/models/address_model.dart';

class UserModel {
  final String? id;
  final String email;
  final String fullName;
  final String userType;
  final String? birthDate;
  final String? cpfCnpj;
  final String? phone;
  final List<AddressModel> addresses;
  final String gender;
  final String? companyName;
  final String? tradeName;
  final String? logoUrl;
  final Map<String, dynamic>? termsAcceptance;

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        fullName = json['fullName'],
        userType = json['userType'],
        birthDate = json['birthDate'],
        cpfCnpj = json['cpfCnpj'],
        phone = json['phone'],
        addresses = List.from((json['addresses'] as List? ?? [])
            .map((e) => AddressModel.fromJson(e))),
        gender = json['gender'],
        companyName = json['companyName'],
        tradeName = json['tradeName'],
        logoUrl = json['logoUrl'],
        termsAcceptance = json['termsAcceptance'];

  toJson() => {
        "id": id,
        "email": email,
        "fullName": fullName,
        "userType": userType,
        "birthDate": birthDate,
        "cpfCnpj": cpfCnpj,
        "phone": phone,
        "addresses": addresses.map((i) => i.toJson()).toList(),
        "gender": gender,
        "companyName": companyName,
        "tradeName": tradeName,
        "logoUrl": logoUrl,
        "termsAcceptance": termsAcceptance,
      };
}
