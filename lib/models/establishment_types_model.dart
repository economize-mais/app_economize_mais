import 'package:app_economize_mais/models/establishment_model.dart';

class EstablishmentTypesModel {
  final String id;
  final String name;
  final String description;
  final List<EstablishmentModel> establishments;

  EstablishmentTypesModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        establishments = List.from(json['establishments'])
            .map((i) => EstablishmentModel.fromJson(i))
            .toList();
}
