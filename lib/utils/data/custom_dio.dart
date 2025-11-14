import 'package:dio/dio.dart';

class CustomDio {
  static String? _token;

  final Dio dio;

  CustomDio()
      : dio = Dio(BaseOptions(
          baseUrl: 'https://economize-mais.onrender.com/api',
        ));

  CustomDio.auth()
      : dio = Dio(BaseOptions(
          baseUrl: 'https://economize-mais.onrender.com/api',
          headers: {
            'Authorization': 'Bearer $_token',
          },
        ));

  static void setToken(String newValue) => _token = newValue;
}
