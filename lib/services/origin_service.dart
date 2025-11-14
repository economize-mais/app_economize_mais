import 'package:app_economize_mais/utils/data/custom_dio.dart';

abstract class OriginService {
  static final _apiAuth = CustomDio.auth().dio;

  static Future<List<Map<String, dynamic>>> getOrigin() async {
    try {
      final response = await _apiAuth.get(
        '/origin',
      );

      return List.from(response.data);
    } catch (e) {
      rethrow;
    }
  }

  static Future postOrigin(int id) async {
    try {
      final response = await _apiAuth.post(
        '/origin',
        data: {'id': id},
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
