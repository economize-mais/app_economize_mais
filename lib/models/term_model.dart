class TermModel {
  final int id;
  final String title;
  final String html;

  TermModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        html = json['html'];

  toJson() => {
        "id": id,
        "title": title,
        "html": html,
      };
}
