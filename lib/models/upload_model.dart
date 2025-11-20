class UploadModel {
  final String url;
  final String originalName;
  final String mimeType;
  final num size;

  UploadModel.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        originalName = json['originalName'],
        mimeType = json['mimeType'],
        size = json['size'];
}
