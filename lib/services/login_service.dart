import 'package:app_economize_mais/utils/data/custom_dio.dart';

abstract class LoginService {
  static final _api = CustomDio().dio;

  static Future login(String email, String password) async {
    try {
      final response = await _api.post('/login', data: {
        'email': email,
        'password': password,
      });

      CustomDio.setToken(response.data['accessToken']);

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
