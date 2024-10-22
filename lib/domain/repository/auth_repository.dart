import 'package:sims_ppob_nutech/domain/entities/auth/login_response_entity.dart';
import 'package:sims_ppob_nutech/domain/entities/auth/regist_response_entity.dart';

abstract class AuthRepository {
  Future<LoginResponseEntity> login(String email, String password);
  Future<RegistResponseEntity> register(String email, String firstName, String lastName, String password);
  Future<void> setToken(String token);
  Future<String> getToken();
  Future<void> clearToken();
}