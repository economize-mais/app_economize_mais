import 'package:app_economize_mais/models/address_model.dart';

class UserModel {
  final String? id;
  final String email;
  final String? name;
  final String type;
  final String? birthDate;
  final String? cpf;
  final String? cnpj;
  final String? phone;
  final List<AddressModel> addresses;
  final String? gender;
  final String? companyName;
  final String? tradeName;
  final String? logoUrl;
  final Map<String, dynamic>? termsAcceptance;
  final bool originAcceptance;

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        name = json['name'],
        type = json['type'],
        birthDate = json['birthDate'],
        cpf = json['cpf'],
        cnpj = json['cnpj'],
        phone = json['phone'],
        addresses = List.from((json['addresses'] as List? ?? [])
            .map((e) => AddressModel.fromJson(e))),
        gender = json['gender'],
        companyName = json['companyName'],
        tradeName = json['tradeName'],
        logoUrl = json['logoUrl'],
        termsAcceptance = json['termsAcceptance'],
        originAcceptance = json['originAcceptance'] ?? false;

  Map<String, Object?> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "type": type,
        "birthDate": birthDate,
        "cpf": cpf,
        "cnpj": cnpj,
        "phone": phone,
        "addresses": addresses.map((i) => i.toJson()).toList(),
        "gender": gender,
        "companyName": companyName,
        "tradeName": tradeName,
        "logoUrl": logoUrl,
        "termsAcceptance": termsAcceptance,
        "originAcceptance": originAcceptance,
      };
}
