class AddressModel {
  final String? id;
  final String street;
  final String number;
  final String neighborhood;
  final String state;
  final String complement;
  final String zipcode;

  AddressModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        street = json['street'],
        number = json['number'],
        neighborhood = json['neighborhood'],
        state = json['state'],
        complement = json['complement'],
        zipcode = json['zipcode'];
}
