class AddressModel {
  final String? id;
  final String street;
  final String number;
  final String neighborhood;
  final String city;
  final String state;
  final String complement;
  final String zipcode;

  AddressModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        street = json['street'],
        number = json['number'],
        neighborhood = json['neighborhood'],
        city = json['city'],
        state = json['state'],
        complement = json['complement'],
        zipcode = json['zipcode'];

  toJson() => {
        "id": id,
        "street": street,
        "number": number,
        "neighborhood": neighborhood,
        "city": city,
        "state": state,
        "complement": complement,
        "zipcode": zipcode,
      };
}
