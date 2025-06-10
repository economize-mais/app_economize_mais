class ZipcodeModel {
  final String street;
  final String neighborhood;
  final String city;
  final String state;
  final String zipcode;

  ZipcodeModel.fromJson(Map<String, dynamic> json)
      : street = json['street'] ?? '',
        neighborhood = json['neighborhood'] ?? '',
        city = json['city'] ?? '',
        state = json['state'] ?? '',
        zipcode = json['zipcode']  ?? '';
}
