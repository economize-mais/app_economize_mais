import 'dart:io';

import 'package:app_economize_mais/utils/data/custom_dio.dart';
import 'package:dio/dio.dart';

abstract class UploadsService {
  static final _apiAuth = CustomDio.auth().dio;

  static Future<Map<String, dynamic>> uploadImage(
      File imageFile, String type) async {
    try {
      final body = FormData.fromMap({
        "file": await MultipartFile.fromFile(imageFile.path),
        "type": type,
      });

      final response = await _apiAuth.post('/uploads', data: body);

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
