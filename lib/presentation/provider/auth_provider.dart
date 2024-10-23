import 'package:flutter/cupertino.dart';
import 'package:sims_ppob_nutech/domain/usecase/auth/login_usecase.dart';
import 'package:sims_ppob_nutech/domain/usecase/auth/regist_usecase.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final RegistUseCase _registUseCase;

  AuthProvider(this._loginUseCase, this._registUseCase);

  bool isLoading = false;
  bool isLoggedIn = false;
  bool isRegistered = false;

  String _message = "";

  String get message => _message;

  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();
    final result = await _loginUseCase(params: {'email': email, 'password': password});

    if (result.data != null) {
      isLoggedIn = true;
    }

    _message = result.message;
    isLoading = false;
    notifyListeners();

    return isLoggedIn;
  }

  Future<bool> registration(String email, String firstName, String lastName, String password) async {
    isLoading = true;
    notifyListeners();
    final result = await _registUseCase(params: {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password
    });

    if (result.status == 0) {
      isRegistered = true;
    }

    _message = result.message;
    isLoading = false;
    notifyListeners();

    return isRegistered;
  }
}