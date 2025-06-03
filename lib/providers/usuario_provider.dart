import 'package:app_economize_mais/models/user_model.dart';
import 'package:app_economize_mais/services/login_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app_economize_mais/models/usuario_model.dart';

class UsuarioProvider extends ChangeNotifier {
  final LoginService loginService = LoginService();

  late UsuarioModel usuarioModel;
  late UserModel userModel;

  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';

  Future login(String email, String password) async {
    _setIsLoading(true);
    try {
      hasError = false;

      final response = await loginService.login(email, password);
      userModel = UserModel.fromJson(response);
    } catch (e) {
      hasError = true;
      errorMessage =
          e is DioException ? e.response?.data['message'] : e.toString();
      print(e);
    }
    _setIsLoading(false);
  }

  _setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
