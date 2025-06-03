import 'package:dio/dio.dart';

abstract class CustomDio {
  static Dio get apiLogin => Dio(BaseOptions(
        baseUrl: 'https://economize-mais.onrender.com/api',
      ));
}
