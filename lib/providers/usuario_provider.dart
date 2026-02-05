import 'dart:convert';

import 'package:app_economize_mais/models/origin_model.dart';
import 'package:app_economize_mais/models/term_model.dart';
import 'package:app_economize_mais/models/user_model.dart';
import 'package:app_economize_mais/models/zipcode_model.dart';
import 'package:app_economize_mais/services/login_service.dart';
import 'package:app_economize_mais/services/origin_service.dart';
import 'package:app_economize_mais/services/shared_preferences_service.dart';
import 'package:app_economize_mais/services/terms_service.dart';
import 'package:app_economize_mais/services/user_service.dart';
import 'package:app_economize_mais/services/zipcode_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UsuarioProvider extends ChangeNotifier {
  UserModel? userModel;

  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';

  Future<void> limparCampos() async {
    userModel = null;
    isLoading = false;
    hasError = false;
    errorMessage = '';

    await SharedPreferencesService.clearAll();
  }

  Future login(String email, String password) async {
    _setIsLoading(true);
    try {
      hasError = false;
      await SharedPreferencesService.clearAll();

      final response = await LoginService.login(email, password);
      userModel = UserModel.fromJson(response);

      await SharedPreferencesService.setString(
          SharedPreferencesEnum.accessToken, response['accessToken']);

      await SharedPreferencesService.setString(
          SharedPreferencesEnum.userModel, jsonEncode(userModel!.toJson()));
    } catch (e) {
      hasError = true;
      errorMessage = e is DioException
          ? e.response?.data['message'] ??
              'Não foi possível conectar. Verifique sua conexão com a internet'
          : 'Um erro inesperado ocorreu';
    }
    _setIsLoading(false);
  }

  Future cadastrarUsuario(Map<String, dynamic> userJson) async {
    _setIsLoading(true);
    try {
      hasError = false;
      await UserService.registerUser(userJson);
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
      final response = await ZipcodeService.getCEP(cep);

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
      final response = await TermsService.getTerms(type);

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

      final response = await TermsService.acceptTerms(id);

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

      final response = await UserService.updateUser(json);
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

  Future<List<OriginModel>> getOrigin() async {
    try {
      hasError = false;

      final response = await OriginService.getOrigin();
      return response.map((item) => OriginModel.fromJson(item)).toList();
    } catch (e) {
      hasError = true;
      errorMessage = e is DioException
          ? e.response?.data['message']
          : 'Um erro inesperado ocorreu';
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future postOrigin(int id) async {
    try {
      hasError = false;

      final response = await OriginService.postOrigin(id);
      return response;
    } catch (e) {
      hasError = true;
      errorMessage = e is DioException
          ? e.response?.data['message']
          : 'Um erro inesperado ocorreu';
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> hasSavedCredentials() async {
    final String? savedAccessToken = await SharedPreferencesService.getString(
        SharedPreferencesEnum.accessToken);
    final String? savedUserModel = await SharedPreferencesService.getString(
        SharedPreferencesEnum.userModel);
    if (savedAccessToken == null || savedUserModel == null) {
      return false;
    }

    userModel = UserModel.fromJson(jsonDecode(savedUserModel));

    return true;
  }

  Future deleteProfile() async {
    try {
      hasError = false;

      final response = await UserService.deleteUser(userModel!.id!);
      print(response);
    } catch (e) {
      hasError = true;
      errorMessage = e is DioException
          ? e.response?.data['message']
          : 'Um erro inesperado ocorreu';
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  void _setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
