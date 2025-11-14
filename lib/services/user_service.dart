import 'package:app_economize_mais/utils/data/custom_dio.dart';

abstract class UserService {
  static final _api = CustomDio().dio;
  static final _apiAuth = CustomDio.auth().dio;

  static Future registerUser(Map<String, dynamic> userJson) async {
    try {
      final response = await _api.post('/user', data: userJson);

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  static Future updateUser(Map<String, dynamic> json) async {
    try {
      final response = await _apiAuth.put(
        '/user',
        data: json,
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
