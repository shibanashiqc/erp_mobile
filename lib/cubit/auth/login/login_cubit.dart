import 'dart:convert';
import 'dart:developer';

import 'package:erp_mobile/repository/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());

  void changeFormValues(String type, dynamic value) {
    emit(ChangeFormValuesState(type: type, value: value));
  }

  final prefs = SharedPreferences.getInstance();

  Future<dynamic> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
    await prefs.remove('modules');
    
  }

  Future<dynamic> getLoggedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') == null) {
      return;
    }
    var res = await _repository.get(0, 0, 'user');
    if (res != null) {
      var modules = res['data']['modules'];
      await prefs.setString(
          'user',
          json.encode({
            'name': res['data']['name'],
            'email': res['data']['email'],
            'profile_photo_path': res['data']['profile_photo_path'],
          }));
      await prefs.setString('modules', json.encode(modules));
      return res;   
    }
  }

  getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  final ApiRepository _repository = ApiRepository();
  Future<LoginResponse> login(Map<String, dynamic> map) async {
    try {
      emit(const LoadingLoginState());
      LoginResponse response = await _repository.login(map);
      emit(const LoadedLoginState());
      if (response.status == 'success') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data['token']);
      }
      return response;
    } catch (e) {
      emit(ErrorLoginState(message: e.toString()));
      rethrow;
    }
  }
}

class LoginResponse {
  final String? status;
  final String? message;
  final dynamic data;
  final dynamic error;
  LoginResponse({this.status, this.message, this.data, this.error});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'],
      error: json['error'],
    );
  }
}
