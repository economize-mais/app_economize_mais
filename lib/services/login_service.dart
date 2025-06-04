import 'package:app_economize_mais/utils/data/custom_dio.dart';

class LoginService {
  final apiLoading = CustomDio.apiLogin;

  Future login(String email, String password) async {
    try {
      final response = await apiLoading.post('/User/login', data: {
        'email': email,
        'password': password,
      });

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future cadastrarUsuario(Map<String, dynamic> userJson) async {
    try {
      final response = await apiLoading.post('/User', data: userJson);

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
