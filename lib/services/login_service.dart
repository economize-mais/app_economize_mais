import 'package:app_economize_mais/utils/data/custom_dio.dart';
import 'package:dio/dio.dart';

class LoginService {
  static String? accessToken;
  final apiLoading = CustomDio.apiLogin;

  Future login(String email, String password) async {
    try {
      final response = await apiLoading.post('/login', data: {
        'email': email,
        'password': password,
      });

      accessToken = response.data['accessToken'];

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

  Future pegarCEP(String cep) async {
    try {
      final response = await apiLoading.get('/ZipCode/$cep');

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future pegarTermo(String type) async {
    try {
      final response = await apiLoading.get(
        '/Terms/$type',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future aceitarTermos(int id) async {
    try {
      final response = await apiLoading.post(
        '/Terms/accept',
        data: {'id': id},
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future update(Map<String, dynamic> json) async {
    try {
      final response = await apiLoading.put(
        '/User',
        data: json,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getOrigin() async {
    try {
      final response = await apiLoading.get(
        '/origin',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      return List.from(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future postOrigin(int id) async {
    try {
      final response = await apiLoading.post(
        '/origin',
        data: {'id': id},
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
