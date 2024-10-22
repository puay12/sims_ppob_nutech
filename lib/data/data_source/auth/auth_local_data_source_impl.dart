import 'package:shared_preferences/shared_preferences.dart';
import 'package:sims_ppob_nutech/data/interfaces/auth/auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final String tokenKey = "token";

  @override
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = await prefs.getString(tokenKey);

    return token!;
  }

  @override
  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  @override
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }
}