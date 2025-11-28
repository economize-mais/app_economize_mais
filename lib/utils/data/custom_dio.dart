import 'package:app_economize_mais/utils/data/dio_interceptor.dart';
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
        ))
          ..interceptors.add(DioInterceptor());

  static void setToken(String newValue) => _token = newValue;
}
