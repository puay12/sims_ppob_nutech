import 'package:flutter/cupertino.dart';
import 'package:sims_ppob_nutech/domain/usecase/login_usecase.dart';
import 'package:sims_ppob_nutech/domain/usecase/regist_usecase.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final RegistUseCase _registUseCase;

  AuthProvider(this._loginUseCase, this._registUseCase);

  bool isLoading = false;
  bool isLoggedIn = false;
  bool isRegisted = false;

  String _message = "";

  String get message => _message;

  Future<void> login(String email, String password) async {
    isLoading = true;
    final result = await _loginUseCase(params: {'email': email, 'password': password});

    if (result.data != null) {
      isLoggedIn = true;
    }

    _message = result.message;
    isLoading = false;
  }

  Future<void> registration(String email, String firstName, String lastName, String password) async {
    isLoading = true;
    final result = await _registUseCase(params: {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password
    });

    if (result.status == 0) {
      isRegisted = true;
    }

    _message = result.message;
    isLoading = false;
  }
}