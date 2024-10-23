import 'package:sims_ppob_nutech/data/interfaces/auth_local_data_source.dart';
import 'package:sims_ppob_nutech/data/interfaces/remote/auth_remote_data_source.dart';
import 'package:sims_ppob_nutech/domain/entities/auth/login_response_entity.dart';
import 'package:sims_ppob_nutech/domain/entities/auth/regist_response_entity.dart';
import 'package:sims_ppob_nutech/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource, this._authLocalDataSource);

  @override
  Future<LoginResponseEntity> login(String email, String password) async {
    return await _authRemoteDataSource.login(email, password);
  }

  @override
  Future<RegistResponseEntity> register(String email, String firstName, String lastName, String password) async {
    return await _authRemoteDataSource.register(email, firstName, lastName, password);
  }

  @override
  Future<void> clearToken() async {
    await _authLocalDataSource.clearToken();
  }

  @override
  Future<String> getToken() async {
    return await _authLocalDataSource.getToken();
  }

  @override
  Future<void> setToken(String token) async {
    await _authLocalDataSource.setToken(token);
  }

}