class EstablishmentModel {
  final String id;
  final String name;
  final String? logoUrl;
  final String? street;
  final int displayOrder;

  EstablishmentModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        logoUrl = json['logoUrl'],
        street = json['street'],
        displayOrder = json['displayOrder'];
}
