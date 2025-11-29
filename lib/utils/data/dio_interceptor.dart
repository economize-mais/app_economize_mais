import 'package:app_economize_mais/utils/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

class DioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      AppRoutes.navigatorStateKey.currentContext?.go('/', extra: true);
    }

    super.onError(err, handler);
  }
}
