import 'package:app_economize_mais/utils/data/dio_interceptor.dart';
import 'package:dio/dio.dart';

class CustomDio {
  static final String _baseUrl = 'https://economize-mais.onrender.com/api';

  final Dio dio;

  CustomDio() : dio = Dio(BaseOptions(baseUrl: _baseUrl));

  CustomDio.auth()
      : dio = Dio(BaseOptions(baseUrl: _baseUrl))
          ..interceptors.add(DioInterceptor());
}
