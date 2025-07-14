import 'package:app_economize_mais/models/term_model.dart';
import 'package:app_economize_mais/models/user_model.dart';
import 'package:app_economize_mais/models/zipcode_model.dart';
import 'package:app_economize_mais/services/login_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UsuarioProvider extends ChangeNotifier {
  final LoginService loginService = LoginService();

  late UserModel? userModel;

  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';

  void limparCampos() {
    userModel = null;
    isLoading = false;
    hasError = false;
    errorMessage = '';
  }

  Future login(String email, String password) async {
    _setIsLoading(true);
    try {
      hasError = false;

      final response = await loginService.login(email, password);
      userModel = UserModel.fromJson(response);
    } catch (e) {
      hasError = true;
      errorMessage = e is DioException
          ? e.response?.data['message']
          : 'Um erro inesperado ocorreu';
    }
    _setIsLoading(false);
  }

  Future cadastrarUsuario(Map<String, dynamic> userJson) async {
    _setIsLoading(true);
    try {
      hasError = false;
      await loginService.cadastrarUsuario(userJson);
    } catch (e) {
      hasError = true;
      errorMessage = e is DioException
          ? e.response?.data['message']
          : 'Um erro inesperado ocorreu';
    }
    _setIsLoading(false);
  }

  Future<ZipcodeModel?> pegarCEP(String cep) async {
    try {
      hasError = false;
      final response = await loginService.pegarCEP(cep);

      return ZipcodeModel.fromJson(response);
    } catch (e) {
      hasError = true;
      errorMessage = e is DioException
          ? e.response?.data['message']
          : 'Um erro inesperado ocorreu';
      return null;
    }
  }

  Future<TermModel> pegarTermo(String type) async {
    try {
      hasError = false;
      final response = await loginService.pegarTermo(type);

      return TermModel.fromJson(response);
    } catch (e) {
      hasError = true;
      errorMessage = e is DioException
          ? e.response?.data['message']
          : 'Um erro inesperado ocorreu';
      rethrow;
    }
  }

  Future aceitarTermos(int id) async {
    try {
      hasError = false;

      final response = await loginService.aceitarTermos(id);

      return response;
    } catch (e) {
      hasError = true;
      errorMessage = e is DioException
          ? e.response?.data['message']
          : 'Um erro inesperado ocorreu';
      rethrow;
    }
  }

  Future update(Map<String, dynamic> json) async {
    try {
      hasError = false;

      final response = await loginService.update(json);
      userModel = UserModel.fromJson(response);
    } catch (e) {
      hasError = true;
      errorMessage = e is DioException
          ? e.response?.data['message']
          : 'Um erro inesperado ocorreu';
      rethrow;
    }
    notifyListeners();
  }

  _setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
