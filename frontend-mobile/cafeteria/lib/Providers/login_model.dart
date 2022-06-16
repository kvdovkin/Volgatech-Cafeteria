import 'package:cafeteria/repositories/authentication_repository.dart';
import 'package:flutter/foundation.dart';

class LoginModel {
  final AuthenticationRepository _authenticationRepository;
  String token = "";
  bool isAuthenticated = false;

  LoginModel(this._authenticationRepository);

  Future<void> login(String name, String password) async {
    try {
      token = await _authenticationRepository.login(name, password);
      isAuthenticated = true;
    } catch (exception) {
      isAuthenticated = false;
    }
  }

  Future<void> register(String name, String password) async {
    try {
      token = await _authenticationRepository.register(name, password);
      isAuthenticated = true;
    } catch (exception) {
      isAuthenticated = false;
    }
  }
}
