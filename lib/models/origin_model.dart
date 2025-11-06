class OriginModel {
  final int id;
  final String description;

  OriginModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'];
}
